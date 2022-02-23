Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1357D4C0B8E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 06:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234868AbiBWFOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 00:14:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233406AbiBWFOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 00:14:32 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA585007F
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 21:14:05 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id d187so14259673pfa.10
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 21:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to;
        bh=SrOCtUKl/yDNUB2r8G3z7e0/mD6aPSIPJ8NFj+z3hxQ=;
        b=YDACMG0VUP+zbeU2kEO09XnTyIZgMb8qcz5x9K5tQp5s0ci9Weezx6PxGi8XqH/fs2
         RrhloXiWwT7mOzY6mNi9xIuBnlZnI1bZf6pQUZDFyBRUTbIDd1opfqFm60+nniuMZj5m
         qCO0G8gYUg3oQcE/184ID+xdzeVkodN2T/ygw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to;
        bh=SrOCtUKl/yDNUB2r8G3z7e0/mD6aPSIPJ8NFj+z3hxQ=;
        b=13lrxVTvZQSztvcDcEXsTSiUsRySU3l+IuRedoEgboCueNO8PoYyEgQMhn14gjqEgp
         c8BP2v0Kcrcz9oQzuxZup+IsrIePRDn536IKKxdO3m1saZTVl4UmGv/K48sbJfKLHf3s
         WOuCvYNuTwRQV6mLav/JQDQ27yaaiVs9gvhmFI6aqZgYA9zdjjRRhodPiAHp4ICiDyX/
         /eI9QIeRpVJzBVcrBtEyTD6NbMTZJrMUMt4LO9ugaMnpqb+M2TYW8njuPOMMzY0xL9oq
         jBU3Yiyg3FLS9Ik5u6Z7FLuexef5cF9dXnG1P37sdSoSCnNt+5huUJV4whp7TvfNGTCN
         Z5Xw==
X-Gm-Message-State: AOAM531YaDDz2RGzqeQhfoQqHnXFn7u+xCRe5AP4FGKdRT8W0QiMBQe0
        c5/YvZTg+SjqTP9uJD2E/EX5Nw==
X-Google-Smtp-Source: ABdhPJySd9W6S7uyRjkaCLJoNLye52/pbyZR0BckfG5+q1PKWC6XSFwVCYuBAix3C/M8VRe5Z676+w==
X-Received: by 2002:aa7:9735:0:b0:4bd:b258:e872 with SMTP id k21-20020aa79735000000b004bdb258e872mr28081744pfg.46.1645593244951;
        Tue, 22 Feb 2022 21:14:04 -0800 (PST)
Received: from [10.136.4.19] ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id u12-20020a17090a890c00b001b8efcf8e48sm1363711pjn.14.2022.02.22.21.14.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 21:14:04 -0800 (PST)
Message-ID: <534605ef-aeb1-b0a2-2326-be6faba4709c@broadcom.com>
Date:   Tue, 22 Feb 2022 21:14:02 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1 1/1] misc: bcm-vk: add kconfig for supporting viper
 chip
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Scott Branden <scott.branden@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>,
        bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org
References: <20220218200811.17136-1-desmond.yan@broadcom.com>
 <YhCdNyRxGYmhx21f@kroah.com>
 <CAEuuh2_b-xGAux_EmBaNCGcBM7C0-Z8d_q1BBZ+LA0zpkZEunQ@mail.gmail.com>
 <YhUZqYrvNy05h86j@kroah.com>
From:   Desmond yan <desmond.yan@broadcom.com>
In-Reply-To: <YhUZqYrvNy05h86j@kroah.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000d5484605d8a888a7"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000d5484605d8a888a7
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Greg,

Please see inlined.

On 2/22/22 09:13, Greg Kroah-Hartman wrote:
> A: http://en.wikipedia.org/wiki/Top_post
> Q: Were do I find info about this thing called top-posting?
> A: Because it messes up the order in which people normally read text.
> Q: Why is top-posting such a bad thing?
> A: Top-posting.
> Q: What is the most annoying thing in e-mail?
> 
> A: No.
> Q: Should I include quotations after my reply?
> 
> 
> http://daringfireball.net/2007/07/on_top
> 
> On Tue, Feb 22, 2022 at 07:41:04AM -0800, Desmond Yan (APD) wrote:
>> Greg,
>>
>> This is to allow the customer to use their own driver, by default,
>> which is their preferred option.
> 
> We do not care about out-of-tree code, and do not add Kconfig options
> just for that, sorry.
> 
> Why not just add the out-of-tree driver here to the in-kernel code?
> What is preventing that from happening today?

Using the bcm_vk driver for viper is only for proof-of-concept, and is 
not aimed to be deployed for production.  In parallel, customer is 
developing their own production-ready driver and would probably upstream 
it whenever the appropriate time comes.

thx.

des
> 
> thanks,
> 
> greg k-h

--000000000000d5484605d8a888a7
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
Y3hUv4qpgBHMYL0QOV49hRCEPA9bdA1E2tJZaPTCgQjIBKTXbV/VA5CMlMe/UjOH6nY1hID+c33O
JjJlS0Q6uDUPv4Xi6hhq1owIm8lcawNZMHODVk3RAgMBAAGjggHZMIIB1TAOBgNVHQ8BAf8EBAMC
BaAwgaMGCCsGAQUFBwEBBIGWMIGTME4GCCsGAQUFBzAChkJodHRwOi8vc2VjdXJlLmdsb2JhbHNp
Z24uY29tL2NhY2VydC9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcnQwQQYIKwYBBQUHMAGG
NWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwME0G
A1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxz
aWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEkGA1UdHwRCMEAwPqA8oDqGOGh0dHA6Ly9j
cmwuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3JsMCMGA1UdEQQc
MBqBGGRlc21vbmQueWFuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSME
GDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUR/AZEnas6F5UTEkX9MSLkmoVu0kw
DQYJKoZIhvcNAQELBQADggEBACgclyA89UFYSNYkHRyDaRI1Yfn2L/TiNQDFtP5Jd+W/g9Ouqvq9
uHw8dCd2QCw8piC0g25U7Q/Tcnfu6sydKZBdtTvv1ZlyCFajkHgSVjZJHmdGAPZdfArtBTlLdYux
VHvqzlQUuX8vTR7zwapU7Q4S3e/wvJljm0qFlEm9iM7c7X6Qev+iYW+cH0a7StliJYAboI8wTeU5
+CRFe63jlAmMwVJgocvWVCzzG9rP+qiMxBVkmg+la+oG0UHXw4aTu+JfvXadtGCFgsfNrJ8Z5do0
X8qLr2r16JY0XDTgGVsdivp1TA9Rgv+1dAof3Hu3oabaRfztJlUXP4A1TylsLVsxggJtMIICaQIB
ATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhH
bG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxu8RiVGamNIPMsivswDQYJ
YIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIBpHu+SyvfEKc/he3+XNwNK+P6pcoQmCK17V
bSukW4MDMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIyMDIyMzA1
MTQwNVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFl
AwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATAN
BgkqhkiG9w0BAQEFAASCAQBvCitCPBQPq7TfIwui5VQrFII5dL/SbVqnyUtuYiLD8yhwNLiC3LXE
aUc9k4BjJKRd9oloOcItaRpXUkBFjgOYQtvHA9oqLuJt78JMuUshPgejwTS4LTA+gKcRHeiq3M59
bubiVV7VIfp3YCRh85N3pfn5rtu/F0IeiZdTXX/1q+u5kLnyqOp6i8WBHiGiVCqz5sBKI46ErXm0
Xhf6mKoxwoObfrBydhfRC0xADTE9IdeaGridDPMhOw4Qt1XnPWA+55YRPt9XuvDDy2ECDDUhAE/v
3b7+l5RkQpjhQk51SIbGrulFUnq/tYaCfT2iJ7DEmbPJL1jIiZS/ry4iZOuB
--000000000000d5484605d8a888a7--
