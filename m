Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E68874F4756
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 01:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345748AbiDEVJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 17:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1458020AbiDERFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 13:05:21 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5099969E;
        Tue,  5 Apr 2022 10:03:22 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id ot30so18069581ejb.12;
        Tue, 05 Apr 2022 10:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=FdSCliDZ7y34gZ+1XXQqplq5BHBXI8/zjaKCt3n8WuY=;
        b=ENTS4odAznIeIHoHtSEu1ZKMCfX2DpQLnUpz2y0sl+WRpZMOLqgow6YaWv7vFm/sbL
         5EFeM47ie6KhM41GyHOuX+697NJqRL4tBfij+Sr7UzQWX1gX+Curkmco1gop1cQwlxLd
         OvyUg8aTb5wiLCJBBt6ouWI4DRkJ6kQ9VaVp4jL2M3TJ6EVU4sWJE2wh1CfIIkD8Rd+z
         xNeo7kn43fkN3gGJD/Fy949N4B+ambl+CFUASPW0ekG/g+jGhuLaLOpm+98dCoVxSblN
         ZIIyBgAwq94xgF7EKjxE2SlgOAM2ZvgB2I2AUAM5qByzxUckonQlN8N7Sp4VyNZvprQo
         jjzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=FdSCliDZ7y34gZ+1XXQqplq5BHBXI8/zjaKCt3n8WuY=;
        b=OaH0y7NzkhNrK9iYye2dF/5J96VNUoo5NoodKXb3BavQZuaZq4zpaLvukUEwKXxsOw
         vvRC3KEdoqqWyn70U47ArUFPD6ZFEtfp0qG7z7cb8RamWeUPyhrDWibv33fQEGpQjevn
         UvQ7x+WSMGPS6wvkFyW1FbFC4GwEOiE4/A6wgLHgTRp4USzhMRcAuiDMdn3moEAPWspP
         SwsXgT5Qq1qNSOXejhMFpQP1uYekb32aV6dcscN0jKAM8WFfCBvPLSFZIFuSZk3wA98D
         rqhYGgAWKphcr1/RJWtbT9FdmMchdDykmDgjt710mQAt9OwQG1k8KngLPRXtOnRRVpny
         0d4A==
X-Gm-Message-State: AOAM533FcshzqzYaxaOUrO0z1i/SJo4nWypszIduFgzCIVZM5l70dXVt
        iiDS9jGvkQiXtPa7Dmmqq9o=
X-Google-Smtp-Source: ABdhPJyeGeuae0b4tOgaXYZ/f7Hp7bTVMfkFRf4fWcB3qvU4PwQHV0bxr3esnA33saHL5j4dayu6OA==
X-Received: by 2002:a17:907:9805:b0:6db:4c33:7883 with SMTP id ji5-20020a170907980500b006db4c337883mr4581508ejc.555.1649178200980;
        Tue, 05 Apr 2022 10:03:20 -0700 (PDT)
Received: from [192.168.3.2] (p5dd1ed70.dip0.t-ipconnect.de. [93.209.237.112])
        by smtp.googlemail.com with ESMTPSA id w9-20020a50d989000000b0041cc3b9b43asm3839271edj.30.2022.04.05.10.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 10:03:20 -0700 (PDT)
Message-ID: <aeb64d1c4bbddfd8463c07a40ab1fc78be0d158d.camel@gmail.com>
Subject: Re: [PATCH  v2 0/4] rpmb subsystem, uapi and virtio-rpmb driver
From:   Bean Huo <huobean@gmail.com>
To:     Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc:     linux-kernel@vger.kernel.org, maxim.uvarov@linaro.org,
        joakim.bech@linaro.org, ulf.hansson@linaro.org,
        ilias.apalodimas@linaro.org, arnd@linaro.org,
        ruchika.gupta@linaro.org, tomas.winkler@intel.com,
        yang.huang@intel.com, bing.zhu@intel.com,
        Matti.Moell@opensynergy.com, hmo@opensynergy.com,
        linux-mmc@vger.kernel.org, linux-scsi@vger.kernel.org
Date:   Tue, 05 Apr 2022 19:03:18 +0200
In-Reply-To: <87r16bk013.fsf@linaro.org>
References: <20220405093759.1126835-1-alex.bennee@linaro.org>
         <8b3ce88f65fd11523a4d2daab3c617f7089eb1ce.camel@gmail.com>
         <87r16bk013.fsf@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.0-1 
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

On Tue, 2022-04-05 at 16:43 +0100, Alex Benn=C3=A9e wrote:
>=20
> Bean Huo <huobean@gmail.com> writes:
>=20
> > Hi Alex,
> >=20
> > Thanks for this unified RPMB interface, I wanted to verify this on
> > our
> > UFS, it seems you didn't add the UFS access interface in this
> > version=20
> > from your userspace tools, right?
>=20
> No I didn't but it should be easy enough to add some function pointer
> redirection everywhere one of the op_* functions calls a vrpmb_*
> function. Do you already have a UFS RPMB device driver?
>=20

Hi Alex,
Thanks for your feedback.

We now access UFS RPMB through the RPMB LUN BSG device, RPMB is a well-
known LU and we have a userspace tool to access it.

I see that if we're going to use your interface, "static struct
rpmb_ops" should be registered from a lower-level driver, for example
in a UFS driver, yes there should be no problem with this registration,
but I don't know with the current way Compared, what are the advantages
to add a driver. maybe the main advantage is that we will have an
unified user space tool for RPMB. right?

Kind regards,
Bean
