Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4793490A37
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 15:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237538AbiAQOYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 09:24:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236869AbiAQOY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 09:24:29 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370CEC061574
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 06:24:29 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id v1so21611464ioj.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 06:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=QnlVfGau/F7tZrXmAnNOwZCm2aBpNZJtPAdbXap2B9Q=;
        b=Hnn1u4Nhy6WmbGVhJOFNJ35nZpV/fua3WdbWMI73tb+kYpCujMzmHh6XpfMJ5KzOE1
         zsCPoZuSVIveBBCJWUtAeQYq9Rrb2DaIJuyC/OvfxItSq2Tu6ILC8sA32TkIm+OIuzIb
         jk36xVOARsEYsWVKP/k02/aaS09EW9L/jWaavEjJAjDWF3QxSw+y9kYn/otg3keknkBq
         QoiLbrvOnV2KZWdpqa35WJf4MxmJfd3z4Bmuv6FzHwzQnJSJa7Dht3grbWdIZeryHe3v
         K8ooJ/rPT1EtMOAjNr4TULKlRvSYLG2UFhGQPEzuRDhAMPKy0+wxUw+5n8nfk/zebfbS
         8NJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=QnlVfGau/F7tZrXmAnNOwZCm2aBpNZJtPAdbXap2B9Q=;
        b=jK97LUhfYWpWNfDodtDa3sB4Ma264IOl3j6/1q7XF1oBV8nLZg2MMp97RU/EqZQU3O
         ML2i45QeiBW4ifEeqErHmXQWor4oW7ym3KdYvo+qRpMIoD2ylbop5nv7MmvGZfD/Rmf0
         rRxtl50MVvHtXRjZcwP9s/XH52fm36sBHv2XbpaI2f0wq9yB9LqWnnJtNlhhA0KJnMa5
         mqMlLvCIe6Y5v0etHhpEA6HE37OzTAbq5WlILS1NQDggt3y75fMZluQAKq+jTICA4x5U
         Ah5+o/UjvhnlblR9n05tRkc6L1c86zvD66xy7KpD+wGU31MhUEJ4J/dRPYCFs4kzwPNU
         Vk2Q==
X-Gm-Message-State: AOAM531JthZMPOgE2W/OaK1jhYUAfbaju60GoJe1UeupUNHHU82Y7E3N
        +GEGN/CRDhDexLEtwV2cjBISp4N+O/MtOg==
X-Google-Smtp-Source: ABdhPJw0Xr+2cSDlHKmpA6oGpcW0KAAJowPBue1b9VJ3CQ1eci4T/Mizn6EDn2eny3u4IbJoQJwr1A==
X-Received: by 2002:a02:cf90:: with SMTP id w16mr9815336jar.94.1642429468615;
        Mon, 17 Jan 2022 06:24:28 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id a2sm1271589iow.7.2022.01.17.06.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 06:24:28 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     GuoYong Zheng <zhenggy@chinatelecom.cn>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1642414957-6785-1-git-send-email-zhenggy@chinatelecom.cn>
References: <1642414957-6785-1-git-send-email-zhenggy@chinatelecom.cn>
Subject: Re: [PATCH] block: Remove unnecessary variable assignment
Message-Id: <164242946547.334981.10563658391509061106.b4-ty@kernel.dk>
Date:   Mon, 17 Jan 2022 07:24:25 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jan 2022 18:22:37 +0800, GuoYong Zheng wrote:
> The parameter "ret" should be zero when running to this line,
> no need to set to zero again, remove it.
> 
> 

Applied, thanks!

[1/1] block: Remove unnecessary variable assignment
      commit: e6a2e5116e07ce5acc8698785c29e9e47f010fd5

Best regards,
-- 
Jens Axboe


