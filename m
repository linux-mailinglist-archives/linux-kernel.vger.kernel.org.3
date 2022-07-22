Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CAC057D9AD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 06:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232830AbiGVEtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 00:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiGVEtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 00:49:49 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1C793638
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 21:49:47 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id ss3so6552601ejc.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 21:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=1zgKFONMAPUnEZdif9mwsS1RgNyE/IjZaTchcJxAMaU=;
        b=fLGzzFvhPVbsLb1WK14VBOQMUFx9+DHe333kbwp2CdISyNeDXFAcMO0fbvByMVj9+G
         1wVQVpL6LTLc3wrkC6fK3j0+WbZeEcejycSsmMiz/l3PQvxstFs9iZFB18Bu+TFaxGoF
         QG04LinNAWz9m7W+bnzYZXjFND6cx0n34UnQMskMHDjzb2mcAm9weohqnIerND4yVs0t
         bMOu5hdZ7hcmXbqvwed/RiG7ExU6Jfucv278pbnSGaRIxGURY7is/FuuX4qpmFqn8gsZ
         bCvPXkutQ6uFcH+ze0f8ocYn5Zj6HmxFC7Gw+eOn4hsRNSZLwhY/rrSxb88sO64piAn3
         LdQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1zgKFONMAPUnEZdif9mwsS1RgNyE/IjZaTchcJxAMaU=;
        b=TPk2YgAFYoPjU16Nq51ySypJ+q+ix5sg9rz7qQmkbbU45P2yHbIcKNngL3DR36G1G9
         YjkOX/VnbZQ39kueCWAWx3hmbJOsmg5gmJ3+tG1nErqnQDv9wQe8G9Qg8y/LXCoNT3Op
         WrsF4E1Tcw8H9E8Ulh4S240mekX9XXh1YgNna2aVeiZHhHpUnzUXWnf7Guy9jek62UT6
         5tGSHTGWQLxuORJ5UUGKbi4UMrrYFLmKHOfeBLVnBrTNhX0fDoUs8qbBZNA2D26kUIzT
         eEI05p/ZdrZ+kr0DKVzrqPV1j+OQe+bKpHCC3hHEoB0a/ZmE1qGRyGzwP8zc+BarGE+Q
         1HkA==
X-Gm-Message-State: AJIora85rJfPr2e5klV0//tAj0GsPrMQrf5aUSNpmabpju73Ky6/BvhP
        Kel3nl9suwxKYPKzEu/VzG0b8KiqP+4=
X-Google-Smtp-Source: AGRyM1sMG2+NAd9ylOZyoM9OoIAxRtk2Z3XZC1xab3vRWup2a/WqJRRaxBdbwFnfFSNwHpLBrAOuhg==
X-Received: by 2002:a17:907:6e12:b0:72e:6774:cb80 with SMTP id sd18-20020a1709076e1200b0072e6774cb80mr1546317ejc.504.1658465385834;
        Thu, 21 Jul 2022 21:49:45 -0700 (PDT)
Received: from ?IPV6:2003:c7:8f2e:6979:bc71:385a:5363:16f9? (p200300c78f2e6979bc71385a536316f9.dip0.t-ipconnect.de. [2003:c7:8f2e:6979:bc71:385a:5363:16f9])
        by smtp.gmail.com with ESMTPSA id kx23-20020a170907775700b0071c6dc728b2sm1540338ejc.86.2022.07.21.21.49.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 21:49:45 -0700 (PDT)
Message-ID: <99475d8c-d556-18b7-ba14-465b19e1472e@gmail.com>
Date:   Fri, 22 Jul 2022 06:49:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3] staging: r8188eu: Inserted empty line after
 declarations
Content-Language: en-US
To:     Abhijeet Srivastava <abhijeet.srivastava2308@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Rebecca Mckeever <remckee0@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>,
        Vihas Makwana <makvihas@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220721141051.45447-1-abhijeet.srivastava2308@gmail.com>
 <20220721141407.45663-1-abhijeet.srivastava2308@gmail.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20220721141407.45663-1-abhijeet.srivastava2308@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/21/22 16:12, Abhijeet Srivastava wrote:
> Warning found by checkpatch.pl script. Resending this patch after
> correcting my Username
> 
> Signed-off-by: Abhijeet Srivastava<abhijeet.srivastava2308@gmail.com>
> ---
> v2:
> 	- Fix my name on the patch
> v3:
> 	- Fix commit message

Why is the "Resending this patch after correcting my Username" still in 
the body of the explanation?

Regards,

Philipp


