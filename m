Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEC3B4EE137
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 20:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237778AbiCaTBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 15:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234070AbiCaTB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 15:01:26 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9374B1BD81B
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 11:59:35 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id r2so580955iod.9
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 11:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=ipWbtJSeprD8JL4tVlpN/eHHk6XD/ZYq3pFkTa23DvI=;
        b=0NCpjxVB+dWiGumo7ptXb4R+kBSxYBNzlCJFoDrHXxMhxhiJ7O9oSjUf0kWfVvPXU2
         Iw7RbnCyEwoUpRdps/IqkgOI7S7zAvlB4c2Ilf0ineQzPljDMed49SveLcA6OnHXNvyG
         pZRUlwrD2qij4FhEi31qbqqHauJFPmC86FMXtUewd0TTtc4LBOl9JKTdmkJdzQmm208C
         /gFBPQ8N+Tw1eNKpzi8as9VQ7YmiuknuQnbC02CXvuezL9WprAS+yni6cZ3tgjGH9v9r
         Ppmnr2mQrBOL09VHBQRAeyt3T8s1YMviEV4xQL/PogQRtjEOQ/mZ6sWwP3C/cekUE5k9
         WyLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=ipWbtJSeprD8JL4tVlpN/eHHk6XD/ZYq3pFkTa23DvI=;
        b=iP4Kv0b8Xmito47NlM0dse82c3742TRHpyrA3bJGBNLgE3CRoH5X/ZSTQ7BGu1ustQ
         bFRjDI5Z/2xkthGb3oJYWWt0WkP5UKfuNCD13FBxkYmC4Vn4H0FgiXItZGMfwKcQQToE
         KAvSXSF9uWrx3FwUIP6bP/YvUe7aLLLfv1PbIwN+1Bxsu7DDJDeeRL+qUIbGvPRRNqk3
         efkti26/Fw7WvDi5vSfnxbgit0tVgDpf0EVUKJRVIlM4IGEo1ck2F/Ov9FS8cYk9wad1
         /5Jv43hFy9XRDj9oWuTPJKiOkF8T/DyjRmCqNhVQk2FEqO/XnNNBowCVQE3f7xsUE/aT
         iQqQ==
X-Gm-Message-State: AOAM532SZba4GB0eZw0rCCg7I3jDHdJAQfzJAbSJGa3VXgO1nyPnLMC6
        Y4S0pUKWmxn7LAaisbprbusOFQ==
X-Google-Smtp-Source: ABdhPJxqYmk0HBczgGNml6Bhr/D+kTxlL2S5eCyqjBCIddKnbs6kQquos6zAL4FTpHQLkjpoaouaTw==
X-Received: by 2002:a6b:e20a:0:b0:648:b6aa:6615 with SMTP id z10-20020a6be20a000000b00648b6aa6615mr15018715ioc.209.1648753174927;
        Thu, 31 Mar 2022 11:59:34 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id v3-20020a92ab03000000b002c9d9d896eesm118783ilh.68.2022.03.31.11.59.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Mar 2022 11:59:34 -0700 (PDT)
Message-ID: <93d0879e-4dac-01db-b29b-d53721076d45@kernel.dk>
Date:   Thu, 31 Mar 2022 12:59:33 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] blk-wbt: remove wbt_track stub
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
To:     trix@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220331185458.3427454-1-trix@redhat.com>
 <d5bb15f0-6531-383f-8e78-0dad58828689@kernel.dk>
In-Reply-To: <d5bb15f0-6531-383f-8e78-0dad58828689@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/31/22 12:56 PM, Jens Axboe wrote:
> On 3/31/22 12:54 PM, trix@redhat.com wrote:
> 
> Not sure how you sent this patch, but there's no body, just an
> attachment. Regular tooling doesn't like that.

Actually b4 likes it just fine, it just wasn't on lore yet. But
for future patches, please do send with git send-email or similar.
I could not view the patch without first saving the attachment
and opening it separately.


-- 
Jens Axboe

