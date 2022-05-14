Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 147515272B1
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 17:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234022AbiENPlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 11:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234011AbiENPlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 11:41:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B9DBCDC;
        Sat, 14 May 2022 08:40:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFB4060FC5;
        Sat, 14 May 2022 15:40:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0AFEC340EE;
        Sat, 14 May 2022 15:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652542858;
        bh=Hvx8z7gxwiLOsB3ma/sekJorZo96PjW6zdwnK9wQID4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tAwQ/ZugvwWvz9PwvgrN/dcexR4VZfLghLOGOD/LMdBSUFOKX/c915hJNUu1GUxoF
         bBIydCl3v/x42Ne86PVisrj8cAByfI+mNXCGdlWdR1WVzby31YeXhb4dsAByu9GHgh
         vFbBHPA2cUzPMXzHzpeNz7iI22daHUjtckmiu3sCGA1DNamn5K4k8yGVXXN2HKKPrX
         WrMtcE2/1kNY19Jk3SgVeMYpSpw4tnyG4j6E7kGMwBEzYoh66O2xOFcECaHuVKxksr
         FAhVyqBJvqZpwSWPYX/TgOPQo6DrM8bSKMt+fLgpftqhY1L32GYQdJBYnGRJ6Tgh4D
         S3A7e96sSzyIA==
Date:   Sat, 14 May 2022 16:49:33 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>,
        Lars-Peter Clausen <lars@metafoo.de>,
        mchehab+huawei@kernel.org, linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        devicetree <devicetree@vger.kernel.org>
Subject: Re: [PATCH V2 6/6] dt-bindings: iio: accel: Add bmi085 and bmi090l
 bindings
Message-ID: <20220514164933.4edbc459@jic23-huawei>
In-Reply-To: <CA+U=DspAtKrDdgrzAyELDULQVjj6eFgMhsZjFCOXXYrxFAW6YQ@mail.gmail.com>
References: <20220510141753.3878390-1-Qing-wu.Li@leica-geosystems.com.cn>
        <20220510141753.3878390-7-Qing-wu.Li@leica-geosystems.com.cn>
        <CA+U=DspAtKrDdgrzAyELDULQVjj6eFgMhsZjFCOXXYrxFAW6YQ@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 May 2022 10:32:55 +0300
Alexandru Ardelean <ardeleanalex@gmail.com> wrote:

> On Tue, May 10, 2022 at 5:18 PM LI Qingwu
> <Qing-wu.Li@leica-geosystems.com.cn> wrote:
> >
> > Adds the device-tree bindings for the Bosch
> > BMI085 and BMI090L IMU, the accelerometer part.
> >  
> 
> I think some datasheet links could be added to this file for the new devices.
> 
> The BMI088 has a link to its datasheet.
> 
> > Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
> > ---
> >  Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml b/Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml
> > index 911a1ae9c83f..4290f5f88a8f 100644
> > --- a/Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml
> > +++ b/Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml
> > @@ -18,6 +18,8 @@ properties:
> >    compatible:
> >      enum:
> >        - bosch,bmi088-accel
> > +      - bosch,bmi085-accel
> > +      - bosch,bmi090l-accel

Alphabetical /numeric order preferred. Also, fun question of compatible
fallbacks as per the previous email.  Other than ID you state the bmi080l
has same scales etc as the bmi088 so that one should definitely have
a fallback to bmi088.

The bmi085 is a little less obvious.  We can detect the difference by
the chip id though so a fallback compatible probably makes sense for
that one as well.  DT maintainers - I'll go with whatever you recommend
on that front.

Also, driver doesn't currently have an of_id_table so relies on the fallback
handling of the spi core. Please add an explicit table to the driver.

Thanks,

Jonathan

> >
> >    reg:
> >      maxItems: 1
> > --
> > 2.25.1
> >  

