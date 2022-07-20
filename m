Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06BF57BCC3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 19:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241168AbiGTRhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 13:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241132AbiGTRhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 13:37:05 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEFCB61D93;
        Wed, 20 Jul 2022 10:37:00 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id z13so7568254wro.13;
        Wed, 20 Jul 2022 10:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=V4YdWem1MQtWNU5GFOqTvs7AtPBQ4aGT4QWc8vfmM9I=;
        b=RS0moYaqEDBZE2VxRPH/n97nweSrMIvjeH8wPpx2RoJrS43jS/RNnJl8QJoRQ5mNQP
         terOyaVwSxoa9t/fjP0+9AieKwpjFfZK4GOcdS4DuPPshjCP2+qCVGKoShSP7OV4AJzM
         7fBpnP+sLshnJcWAs5fhInZF3/MdD0oHQQkyKDbNQT7NQD6CD9snOf+JK9M+GJxAafHV
         nXPPP6v4p3jcalodrUHnaEyZ+D98/Q20jF/9O0ROse8z1NzW1w/ZEjc8qiqePGv2Wn/w
         xUk9nHLRmFAp7c+x3Zb9mYlnA1i5epwvmbuPiXRCQB7MSdnbzKt0fHdDsp3wDCB6n7RZ
         xjtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=V4YdWem1MQtWNU5GFOqTvs7AtPBQ4aGT4QWc8vfmM9I=;
        b=riI4bb7Kh3I93q8OHw9qbOMQcFAEXD6mqzRBs9CsrGGsEKM8Z8MN8tadeyOb7twqof
         vlGCpgRd+khJbka4lq2YnH9mCaO6tcmBEjJCri/JjVKnECuhwYavYX9z0FgXHXqJ6Sxb
         QGVI3Q5/u+lbui0XjHeObyhc6Y9msKxpHgPKEKZ+5JG2ChnNqUkgI4CmYo9ixRDQaT1i
         6jfIpI3v/+JRtZh2f6SLHjIg8bHSfgzCuH/ax4n0eQPwvT69i5/EKu9qgxS1IBuvge/i
         KD3/rTw/Frb/uJMOGCUu46aWqd0vtYX2Nx8KvoVJDDSoRiWL0i3mXO821iHnIdfnPlvJ
         p+hQ==
X-Gm-Message-State: AJIora/2ogqEruxsgyGa0PX04yAMDYb/D+w2l9aXDvm2CAxjFGdjKCia
        dRSDQ2AKrcawubdBbOTOQ5A=
X-Google-Smtp-Source: AGRyM1tyxhtCBVu9P+rIW4ONBn4ZSHmpD89B4CDcopUYZz2TljcEcdkzDbIim41BW/Bw+VHhqfgs/Q==
X-Received: by 2002:a5d:64ac:0:b0:21d:7832:ecf9 with SMTP id m12-20020a5d64ac000000b0021d7832ecf9mr31188117wrp.86.1658338619170;
        Wed, 20 Jul 2022 10:36:59 -0700 (PDT)
Received: from elementary ([94.73.36.185])
        by smtp.gmail.com with ESMTPSA id g18-20020a05600c001200b003a31169a7f4sm3059133wmc.12.2022.07.20.10.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 10:36:58 -0700 (PDT)
Date:   Wed, 20 Jul 2022 19:36:56 +0200
From:   =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To:     Nikolai Kondrashov <spbnick@gmail.com>
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] UCLogic: Filtering unsupported HUION tablets
Message-ID: <20220720173656.GA3725@elementary>
References: <20220718172953.6817-1-jose.exposito89@gmail.com>
 <5d4ef0df-083f-a00e-fb41-1ce1df6e9473@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5d4ef0df-083f-a00e-fb41-1ce1df6e9473@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nikolai,

Thanks a lot for the quick response.

On Tue, Jul 19, 2022 at 12:57:09PM +0300, Nikolai Kondrashov wrote:
> Hi José,
> 
> First of all, thanks a lot for all the work you're doing with the tablets!
> 
> Yes, this situation is unfortunate, but there's really not much we could do.
> The tablet database at http://digimend.github.io/tablets/ hasn't been
> updated in ages, and it has never been exhaustive to start with.
> 
> There are tons of tablet modifications, including of the same (marketed)
> model, and those can differ not only in the reported name, but probably even
> the VID:PID, as could've happened when Huion switched from v1 to v2
> protocol.
> 
> So, I think a "whitelist" would be a maintenance nightmare.
> 
> Moreover, I think it's better to disable the tablet completely in case we
> failed initialization (e.g. got an invalid response to configuration, or
> failed to find some interfaces and such), after producing a comprehensive
> error message. Configuring a tablet partially, and then handing it over to
> the generic driver could mess things up more.
> 
> It's less confusing for the user, and stops them from trying to fix the
> problem up the stack with various settings, often getting into a worse
> situation. It's also much easier for the maintainer, since they don't need
> to investigate all the higher layers.
> 
> A "blacklist" would work better here, if you can find the tablets to include.
> 
> Nick

That makes sense, thanks for the pointers.

It is unfortunate that we don't have the required information about the
supported tablets. Excluding the unsupported tablets (when fixing them
is not possible for reasons) seems like a reasonable approach.

I don't know about any broken device handled by the driver, so there is
no need to add new code yet :)
I'll try to keep an eye on DIGImend's issue tracker now that the code
present in the upstream kernel is being released by many distros.

Cheers,
Jose

> On 7/18/22 20:29, José Expósito wrote:
> > Hi!
> > 
> > No code yet, just a kind request for comments and hopefully some wisdom
> > and experience from Nikolai dealing with HUION devices.
> > 
> > HUION keeps reusing the same vendor and product IDs for their devices.
> > This makes it really difficult to differentiate between devices and
> > handle them in the kernel and also in user space.
> > 
> > Reusing IDs could introduce a problem:
> > 
> > If HUION, or other vendor following the same practices, releases a new
> > tablet with a duplicated product ID, the UCLogic driver would handle it.
> > The device might work with the existing code or it might fail because of
> > a new feature or a whole different firmware.
> > 
> > As far as I know, at the moment there is not a mechanism in place to
> > avoid this situation.
> > I think that it'd be better to ignore those devices in UCLogic and let
> > the HID generic driver handle them because using HID generic would
> > provide a basic user experience while using UCLogic might fail to probe
> > the tablet.
> > 
> > DIGImend's web already provides a nice list of supported devices:
> > http://digimend.github.io/tablets/
> > 
> > So, I wonder:
> > 
> >   - Do you think it makes sense to ignore untested devices?
> >   - If the answer is yes, do we have a better option than checking the
> >     device name against an allow-list? It'd be great to hear other
> >     people's ideas.
> > 
> > Best wishes,
> > José Expósito
> > 
> 
