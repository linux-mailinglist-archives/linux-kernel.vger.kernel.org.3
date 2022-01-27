Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D39B849E8B4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 18:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244450AbiA0RTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 12:19:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiA0RTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 12:19:12 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF26FC061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 09:19:11 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id z4so3084189ilz.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 09:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=PN5u6+QeNQRsASgfQITq6sGSB7/LNkABHim8OIkAXSY=;
        b=ojjWJeCjUXZ9zXtEIvtZv1HiZLRKl9mVCrg4wRuNp4Ix/fsHTeIOHIhPWZZZTBd0bX
         gBznePrhgLHdleBHR/jqLuwSsFAIV8O4e8XzHjks3IYWcLZ+UItKVFfKCC7WIIfhhzzo
         Cl7e1mv5XdN86aF7Xry8TyqkU9gLdld16AYhrCIztRo5CEsPaZB9w4hsl0tLK0Yn1Rpm
         oyrLp7axF+7p+gCXQ8Uo6ViJxRlo05UpYDFbohzm2I0cAJGcACiPLP522SD3RcsNbV2G
         vCoAEjQIXMmaw05+1MA1JOp3bX7B8PLt6jXQFjnDW6HM6dQ0oEtcEtGOajfHiplxq8a7
         yyug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=PN5u6+QeNQRsASgfQITq6sGSB7/LNkABHim8OIkAXSY=;
        b=rrqKE4N5JwR6wyae8NlLsMGWcXoSK9jeAye6R5GoNesviaKLOuu4T5hNMCqxZCq4Mj
         BR8l/gG96rlwsgtj13FbKpT8YjLzriyUfWfYezwRWaWNFmPPXMruL8ocgRLaf0bSsh/P
         mHy2SgOIJeMrPLV6uJnj/ymXy2tsSilgoEjZ17JhX0pmG/ikubZjCy4Q7zqt1c9pH41t
         yk5bBJCcXPv/GjFUFsayU1r9bMHUaZy5bErht7NnhQrhJqggHE+iiE9lhJ3ahDpb6MXF
         vOkGPDq/FqoNagnefUIlWBLcoupev0tDvwLxvb/nCjK85ZGzv7hOttHP88wGneWHuUIc
         CeFw==
X-Gm-Message-State: AOAM532aQXqUFTV/U8/NoCxLwEJP6INp/BpKwONIVi9JGEPPxz+RezKM
        h9piBqjNgbBmrcdSBE5THHrr9w==
X-Google-Smtp-Source: ABdhPJzJfmAhaB4REm9uAJrFOsiwJdsu78f3KJ1zUkwa2CRRS+nxMQszAqviQDW4srMxwLEgwWcPxQ==
X-Received: by 2002:a05:6e02:15c4:: with SMTP id q4mr3328454ilu.15.1643303951105;
        Thu, 27 Jan 2022 09:19:11 -0800 (PST)
Received: from x1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id p13sm740024iod.51.2022.01.27.09.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 09:19:10 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Usama Arif <usama.arif@bytedance.com>,
        linux-kernel@vger.kernel.org, asml.silence@gmail.com,
        io-uring@vger.kernel.org
Cc:     fam.zheng@bytedance.com
In-Reply-To: <20220127140444.4016585-1-usama.arif@bytedance.com>
References: <20220127140444.4016585-1-usama.arif@bytedance.com>
Subject: Re: [PATCH] io_uring: remove unused argument from io_rsrc_node_alloc
Message-Id: <164330395052.210938.1004883537285107042.b4-ty@kernel.dk>
Date:   Thu, 27 Jan 2022 10:19:10 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jan 2022 14:04:44 +0000, Usama Arif wrote:
> io_ring_ctx is not used in the function.
> 
> 

Applied, thanks!

[1/1] io_uring: remove unused argument from io_rsrc_node_alloc
      commit: f6133fbd373811066c8441737e65f384c8f31974

Best regards,
-- 
Jens Axboe


