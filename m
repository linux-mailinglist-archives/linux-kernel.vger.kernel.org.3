Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4186659FF4F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 18:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239528AbiHXQRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 12:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237458AbiHXQRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 12:17:14 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BCF82F678;
        Wed, 24 Aug 2022 09:17:13 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id w10so10566888edc.3;
        Wed, 24 Aug 2022 09:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc;
        bh=FZBX5TSeKzh+jQaCfCT0X7ymr1LiUTEMVL0+7NXBRDA=;
        b=E7yxE9QlMhUY/AzG5CdOgbt9ctDyWevIndis57SEwilCbVE+I+qbhtoZGhRkUWCdyS
         MZkJpW9zChQsaYPwBwQGBDwIScnsDRuRmkGcCY/EH3/ltV3uULzuZmPqKptFtbioibwQ
         +zwhQrIyq6loY5557B8BpmtejPsL7IfdLTvgG9KQvmlBZaKKI8X/ww6KWuummHZa/XN/
         ZWSRqZoIStMmpcJQuGoUZKyrW4SgFhm1g1aoRcAvZV6NOq4G5srX/Nag7gTDp4EH83Xf
         bTTsPJUVMKMHcqJEVEJqq1BQes5Riq9gZmi6U8Ow7tVDzmwrJKyH4tvY+i+uJKYzLs34
         RX8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc;
        bh=FZBX5TSeKzh+jQaCfCT0X7ymr1LiUTEMVL0+7NXBRDA=;
        b=xIInqt7cSZkVGX23UbsBiGkwZ7ALhJBogvp3jr9P2S0bxH1R6EeY2LjoAfnIw8Tz2I
         4mfKH2KcgM2DT/SuKAOXYhPE4Qq/beSxAPI27lZfw7OyELmq6fxjPsiqCZNdLW9Ce0g1
         qYcmO5Nn2qXzgSOLz1TEJ3Ol0nKH2yLpHfV3AN/UAPxi7NUrIhj54KFPP9lbeZjqT9cr
         zcflPo58mriV8LIfck3k2H+AkPtkaz4xXuqafyHKq1gLjflrorD8Ms8ghf8wNXj+soKi
         w04CyvHThsH/njcpgWCfa4CeIpK1SYieRbEYhBX7VB6v0yaEXsZKfOuTfNMn+2ZbQkW7
         Q7Fw==
X-Gm-Message-State: ACgBeo3aAMpUlHoRS+Zfk4BFWFjRC+LHV42Hr0VPxV4F5phVfPdsIyAT
        yEUJ+1YB24LKUaqCacNKOfI=
X-Google-Smtp-Source: AA6agR5H214GEyLqkPmrMW22/NI3k1GTgOJzvSRPNG1hMEtm7kKiUj2S4YJWnC1yUw3+l666QRDHIw==
X-Received: by 2002:a05:6402:88e:b0:445:e4c2:b8bf with SMTP id e14-20020a056402088e00b00445e4c2b8bfmr8053976edy.50.1661357831816;
        Wed, 24 Aug 2022 09:17:11 -0700 (PDT)
Received: from [10.176.234.249] ([137.201.254.41])
        by smtp.googlemail.com with ESMTPSA id e6-20020a1709061e8600b0072b7d76211dsm1339658ejj.107.2022.08.24.09.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 09:17:11 -0700 (PDT)
Message-ID: <317f153d806e063a2e534555a6329dc2efb662b8.camel@gmail.com>
Subject: Re: =?UTF-8?Q?=E7=AD=94=E5=A4=8D=3A?= [External Mail]Re: [PATCH]
 scsi: ufs: ufsfbo: Introduce File Based Optimization feature
From:   Bean Huo <huobean@gmail.com>
To:     =?UTF-8?Q?=E6=9D=8E=E4=BD=B3=E9=93=AD?= <lijiaming3@xiaomi.com>,
        Jiaming Li <lijiamingsofine@gmail.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>
Cc:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Wed, 24 Aug 2022 18:17:10 +0200
In-Reply-To: <ce75888f5f2a412283a839ebd0015735@xiaomi.com>
References: <20220824084633.14428-1-lijiamingsofine@gmail.com>
         <347dae29c07fe13e6974b0e59e127c399f63ef69.camel@gmail.com>
         <ce75888f5f2a412283a839ebd0015735@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-08-24 at 15:26 +0000, =E6=9D=8E=E4=BD=B3=E9=93=AD wrote:
> Hi Bean
> This is a UFS extended feature in UFS4.0 JEDEC Standard
thanks, I see, it's officially released.

I think you should rebase your driver, the ufs driver has been taken
out of the scsi folder.

Kind regards,
Bean
