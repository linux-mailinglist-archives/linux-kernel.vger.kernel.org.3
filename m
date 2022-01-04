Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3C63483DAA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 09:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbiADIH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 03:07:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232556AbiADIHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 03:07:24 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCDFEC061761;
        Tue,  4 Jan 2022 00:07:23 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id o63-20020a17090a0a4500b001b1c2db8145so40051965pjo.5;
        Tue, 04 Jan 2022 00:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=chAdkmt9mGlLdT8NC3d5bJUWTSNgWZ4fLUZ3IUs+cNM=;
        b=eqKb7YQrjCYsfxANbusZS7p9ccp8uPrg7PwRXONul7QMhMUBPcx3LCbDpQTnMkCWaW
         MXbIuMecmfkUhxxkmjB1nvNGzckc20WBMxPwv+KszZBYGQWVDJ7DE0eXrvFvKFtwtNeE
         9S3KNbWb5CQ1gurleG6zjU6RHqScpPgdrrsOsY5K6BkOGSDk4O3uuIBpb0DA/SHTF5Uy
         oRfsvp9ZbeLtX8SJq5Icp/thiotYhNG3oAXCWJ426b0oLSp5gqEHnFNdsJDIdFg7HRQn
         p6ZOXQPJkMrZyA+a4/Iiy6HqRmub31RGWWZDvbMezbM4Y7ZSILsZQDS1MqRFzQspHqhq
         7JZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=chAdkmt9mGlLdT8NC3d5bJUWTSNgWZ4fLUZ3IUs+cNM=;
        b=QBIoJf5TPicLEy2Zpj6VQ6XrxgvA4HlHM+Stujcz1NzGWtAH844htjh8si5CcLR3Yh
         Cq6BApmUxnr2HVD+kstmKc1RKuf72sO2ahxUZZ9gI8ZaRZ1POh2W0ZaTW/rEYOFUzR0G
         az79YGfrPPrC31N9tYrn0Ir9ci4xK+ZJae9DnnM8WivaoMgzcOg73T2W7YkDth4YEOzq
         vXKxsR9WUK6jBcxAJxce4ob8IUBXRLF+8KAT41T8XQvo4RPoI2dc3WiXdJmV0S9pX1oB
         WjV7D25zu2p9l+3A/KMwHMvXqZgp52AIBydOmdL6y4i3+EiGS8zbJ81Hf5r/0CZbu8j4
         rn3Q==
X-Gm-Message-State: AOAM532Xhco2fN33LzJwumNmIjOzxQBK2OvjuYW732s/rCaqVjUkEXkO
        X2cq2ZOuq9QDrXtg+D8SENfE4D+IOAs=
X-Google-Smtp-Source: ABdhPJyDtfgf4YWv71JHpHdevIW8eEJRiLHSsuo4bL2FUfFayRzoWpgj/X26BORkS3LHqgcFT9gxCw==
X-Received: by 2002:a17:902:bc86:b0:149:8dd5:a382 with SMTP id bb6-20020a170902bc8600b001498dd5a382mr31988097plb.52.1641283643413;
        Tue, 04 Jan 2022 00:07:23 -0800 (PST)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id e21sm23924174pff.24.2022.01.04.00.07.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jan 2022 00:07:23 -0800 (PST)
Subject: Re: make pdfdocs fails on Debian stable
To:     Christoph Hellwig <hch@lst.de>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, mchehab@kernel.org
References: <20220104064708.GA15446@lst.de>
 <8f21b702-abc2-c9aa-7593-9aff17e61ed1@gmail.com>
 <20220104073625.GA16910@lst.de>
 <df9183cc-aecb-6b8d-0580-92c2a678d69f@gmail.com>
 <20220104075655.GA17315@lst.de>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <931f9f77-e418-4359-65b1-cb7432e37a0f@gmail.com>
Date:   Tue, 4 Jan 2022 17:07:20 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220104075655.GA17315@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jan 2022 08:56:55 +0100, Christoph Hellwig wrote:
> On Tue, Jan 04, 2022 at 04:53:15PM +0900, Akira Yokosawa wrote:
>> Hmm, I can't reproduce this on docs-next.
>> On which tree are you building RCU.pdf?
> 
> Current linux-next.  But I've also seen it with mainline from a few days
> ago.
> 

Still can't reproduce with sphinx-build 4.3.2 on Debian bullseye.

What version of Sphinx are you using?

