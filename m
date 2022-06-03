Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5985953CC4D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 17:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245520AbiFCP3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 11:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243135AbiFCP3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 11:29:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91CDF26C0;
        Fri,  3 Jun 2022 08:29:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 465DBB82369;
        Fri,  3 Jun 2022 15:29:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07634C385B8;
        Fri,  3 Jun 2022 15:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654270167;
        bh=KpdflRmfJ1wqM76YeOe+UDrket/jjDmryFB7TRBR1sU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=moR+UWAbJPl7c+xFlqYioyenD4HGkV4JkG2Lt8Cxw7Gy5AwD0m00YF1XhQ2ywzcCd
         5Hu9DONZ3FzUnf835M67Nes1dD7rojh5sRvRXxePoW7hecrkluoi1QGbuHN9LQAC05
         zmjcmNV7IbfipmGrcZlWxczSULCgHHPZL+KOj3t9N76oMM3n9peOQblqbRRu18mWyU
         7BWpr9yZ0Dty3s0sNQVwcqV069ha4yH/vITDH9eBAm5pOtyTFq5Q/zBTFOfTD2cs2x
         iF4WUSqYIkEMUqriFY2gTC/zzwHin7yByrpE0Vv6Olb9dcY9gDy/0IijE1LApnRuE5
         qG1p0AoS16ljg==
Date:   Fri, 3 Jun 2022 16:38:26 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     LI Qingwu <qing-wu.li@leica-geosystems.com.cn>
Cc:     Rob Herring <robh@kernel.org>, "lars@metafoo.de" <lars@metafoo.de>,
        "mchehab+huawei@kernel.org" <mchehab+huawei@kernel.org>,
        "ardeleanalex@gmail.com" <ardeleanalex@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mike.looijmans@topic.nl" <mike.looijmans@topic.nl>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        HAEMMERLE Thomas <thomas.haemmerle@leica-geosystems.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH V5 6/6] dt-bindings: iio: accel: Add bmi085 and bmi090l
 bindings
Message-ID: <20220603163826.65d06e0a@jic23-huawei>
In-Reply-To: <AM9PR06MB78445C0FE66A61F6BAC4CE35D7A19@AM9PR06MB7844.eurprd06.prod.outlook.com>
References: <20220526133359.2261928-1-Qing-wu.Li@leica-geosystems.com.cn>
        <20220526133359.2261928-7-Qing-wu.Li@leica-geosystems.com.cn>
        <20220602135734.GA2198822-robh@kernel.org>
        <AM9PR06MB78445C0FE66A61F6BAC4CE35D7A19@AM9PR06MB7844.eurprd06.prod.outlook.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Fri, 3 Jun 2022 07:32:17 +0000
LI Qingwu <qing-wu.li@leica-geosystems.com.cn> wrote:

> > -----Original Message-----
> > From: Rob Herring <robh@kernel.org>
> > Sent: Thursday, June 2, 2022 9:58 PM
> > To: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
> > Cc: jic23@kernel.org; lars@metafoo.de; mchehab+huawei@kernel.org;
> > ardeleanalex@gmail.com; linux-iio@vger.kernel.org;
> > linux-kernel@vger.kernel.org; mike.looijmans@topic.nl;
> > devicetree@vger.kernel.org; HAEMMERLE Thomas
> > <thomas.haemmerle@leica-geosystems.com>
> > Subject: Re: [PATCH V5 6/6] dt-bindings: iio: accel: Add bmi085 and bmi090l
> > bindings
> > 
> > This email is not from Hexagon's Office 365 instance. Please be careful while
> > clicking links, opening attachments, or replying to this email.
> > 
> > 
> > On Thu, May 26, 2022 at 01:33:59PM +0000, LI Qingwu wrote:  
> > > Adds the device-tree bindings for the Bosch
> > > BMI085 and BMI090L IMU, the accelerometer part.
> > >
> > > Datasheet:  
> > https://eur02.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.bos
> > ch-sensortec.com%2Fmedia%2Fboschsensortec%2Fdownloads%2Fdatasheets%
> > 2Fbst-bmi085-ds001.pdf&amp;data=05%7C01%7C%7C6bb7d63d627c49b946c4
> > 08da449fd9bf%7C1b16ab3eb8f64fe39f3e2db7fe549f6a%7C0%7C0%7C6378977
> > 51065729986%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjo
> > iV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdat
> > a=K3PYyQAGsySCIjKuo1QRVm1HE0cuC3BVXbjuAwwhMjM%3D&amp;reserved=
> > 0  
> > > Datasheet:  
> > https://eur02.safelinks.protection.outlook.com/?url=https%3A%2F%2Fmedia.di
> > gikey.com%2Fpdf%2FData%2520Sheets%2FBosch%2FBST-BMI090L-DS000-00.p
> > df&amp;data=05%7C01%7C%7C6bb7d63d627c49b946c408da449fd9bf%7C1b1
> > 6ab3eb8f64fe39f3e2db7fe549f6a%7C0%7C0%7C637897751065729986%7CUnk
> > nown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1h
> > aWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=8GfqaDLkn5whi%2F
> > bsEH9UATPNkJVgsy859sIifJGv%2BHg%3D&amp;reserved=0
> > 
> > blank line here. These aren't part of the tags.  
> Thank you, Rob, I did check, the most datasheets are part of the tags,
> and few of them has a blank line, do you agree to keep it?

Seems we have some disagreement on this.  Personally I thought they'd been
adopted as a standard tag block entry, though I can't immediately find
a clear statement of that. 

+CC Andy who has commented on this before.


> > 
> > With that,
> > 
> > Acked-by: Rob Herring <robh@kernel.org>
> >   
> > > Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
> > > ---
> > >  Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml  
> > b/Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml  
> > > index 911a1ae9c83f..272eb48eef5a 100644
> > > --- a/Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml
> > > +++ b/Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml
> > > @@ -17,7 +17,9 @@ description: |
> > >  properties:
> > >    compatible:
> > >      enum:
> > > +      - bosch,bmi085-accel
> > >        - bosch,bmi088-accel
> > > +      - bosch,bmi090l-accel
> > >
> > >    reg:
> > >      maxItems: 1
> > > --
> > > 2.25.1
> > >
> > >  

