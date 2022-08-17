Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C042959669B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 03:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237025AbiHQBS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 21:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiHQBSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 21:18:54 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F1F30F6D
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 18:18:51 -0700 (PDT)
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id F1A453F165
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 01:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1660699129;
        bh=QB/N93Jt8jeRbC+nYshhBQqqf2b7gP/bAzKdLJW4IoY=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=NMYkjZeax++J7fEsyJYct1SlrQZpf6KPSGNea6DqyA128/x+zybH6clt9DX9s6Onp
         E/P8WyQwxWBgCYWDQtzrBo1ANuhg8xp23bRltFMSkyKz5on8hfTCTnfM+3GUJdujdK
         wUuVCU23fJO/SpB4gNCFQB/fojohdyEY+9KFuteuy9toUeNRC0So1/QROl9mfIKWeH
         OcNkiji7ZvpqLmrFW9YtsK/lQfKGlFAHU0xs/Dsqs80kXIiZHO9LMxK01w1G8MMfe2
         lXunxOCOlDBUluYwbHWP7sLap4FMLEZS8f27L/rFe0QWRaMh9YjAh9wPHPDvuVAuV5
         qXNVPDUfyFgsg==
Received: by mail-ot1-f71.google.com with SMTP id h4-20020a056830034400b00638c37d1349so1339520ote.10
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 18:18:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=QB/N93Jt8jeRbC+nYshhBQqqf2b7gP/bAzKdLJW4IoY=;
        b=U/gbIKBXt3vM06tz+pFEiwmX7s10iFDYjHi6b8/e8K6Kqky7hulysLfr/ynSvNSZGh
         0dCyBvV1KMITcxipoL23DtPYT3KDWJyNbOoHiYaRl+9SeBqQm808w6NrOjh6fj1jaXCi
         Dgvm+rpfvL5HDKW2Q84F0mNvrZW2XT1KyQSzYh3cbDIRRMG5eJLFcnagGa21FJPojSu0
         CQTrUKPwQbt4iWjttYDUeyHpxJcU7T9A+4WjiJn29796B1Pwwoxay7pMllVURRdH+tow
         BQXxdeAx43soP7kjHd/kyJzk7AnUheTHt5ZgUA2rBEi2uw15a+KwaPS59GZL20uikgwf
         6mjQ==
X-Gm-Message-State: ACgBeo0dXaxzuJNS4D049nywqDd5PRx+7W9grk7DjvXz71yxIJLQU89E
        puQIVkgrycqKw5NXHKdpvy/xZ9vrmlGQs0mLqbr4jxVbv3eEhNOft+6NBrJLBo6Smw18EaLH+Zm
        iHOnpP0fh92+avCVBMALM68wH5uzFuxzNLttXwosSdZBy/jhTYBVRQpvpWQ==
X-Received: by 2002:a05:6808:209f:b0:344:8f50:1f29 with SMTP id s31-20020a056808209f00b003448f501f29mr538902oiw.42.1660699128693;
        Tue, 16 Aug 2022 18:18:48 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4z0ckBseo0DvhMsjK8u68wPgPVvhD5xGInUN9KS3WKNbIl+FGWT86akRupbmaylKkx03qn6le2zNiMt4kSPAI=
X-Received: by 2002:a05:6808:209f:b0:344:8f50:1f29 with SMTP id
 s31-20020a056808209f00b003448f501f29mr538889oiw.42.1660699128446; Tue, 16 Aug
 2022 18:18:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220816025217.618181-1-kai.heng.feng@canonical.com> <CACO55tt=Op=0E94kK+1M8cDXNCk5Tkc=FMR8=OQFc5ohehjwaw@mail.gmail.com>
In-Reply-To: <CACO55tt=Op=0E94kK+1M8cDXNCk5Tkc=FMR8=OQFc5ohehjwaw@mail.gmail.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Wed, 17 Aug 2022 09:18:36 +0800
Message-ID: <CAAd53p49X95MKrTDUq92LuHw3y2i09fUA2HEPzM1EcO8xO97Eg@mail.gmail.com>
Subject: Re: [PATCH] drm/i915: Switch TGL-H DP-IN to dGFX when it's supported
To:     Karol Herbst <kherbst@redhat.com>
Cc:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Hans de Goede <hdegoede@redhat.com>,
        Zenghui Yu <yuzenghui@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 2:50 AM Karol Herbst <kherbst@redhat.com> wrote:
>
> On Tue, Aug 16, 2022 at 4:53 AM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
> >
> > On mobile workstations like HP ZBook Fury G8, iGFX's DP-IN can switch to
> > dGFX so external monitors are routed to dGFX, and more monitors can be
> > supported as result.
> >
> > To switch the DP-IN to dGFX, the driver needs to invoke _DSM function 20
> > on intel_dsm_guid2. This method is described in Intel document 632107.
> >
>
> Can we please not do things like this just because?

I there's a very good reason to support more external monitors,
especially when eDP is already 4K so iGPU don't have enough buffer for
more displays.

>
> It forces the discrete GPU to be on leading to higher thermal pressure
> and power consumption of the system. Lower battery runtime or higher
> fan noise is the result. Not everybody wants to use an AC simply just
> because they attach an external display.

The system is designed in this way.

And many (if not all) gaming laptops and mobile workstations use
discrete GPU for external monitors.
We just recently found out we have to use a switch to make it work.

>
> If the problem is "we run out of displays" then can we have something
> more dynamic, where we are doing this only and only if we run out of
> resources to drive as that many displays.

This is a boot-time switch, so it's not possible to switch it dynamically.

>
> Most users will be fine with ports being driven by the iGPU. Why hurt
> most users, because of some weird special case with mostly only
> drawbacks?

This is a use case that hardware vendor never bother to test.
And this is not a special case - the system is designed to use dGPU
for external monitors.

Kai-Heng

>
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> >  drivers/gpu/drm/i915/display/intel_acpi.c | 18 +++++++++++++++++-
> >  1 file changed, 17 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/i915/display/intel_acpi.c b/drivers/gpu/drm/i915/display/intel_acpi.c
> > index e78430001f077..3bd5930e2769b 100644
> > --- a/drivers/gpu/drm/i915/display/intel_acpi.c
> > +++ b/drivers/gpu/drm/i915/display/intel_acpi.c
> > @@ -20,6 +20,7 @@ static const guid_t intel_dsm_guid =
> >                   0xa8, 0x54, 0x0f, 0x13, 0x17, 0xb0, 0x1c, 0x2c);
> >
> >  #define INTEL_DSM_FN_GET_BIOS_DATA_FUNCS_SUPPORTED 0 /* No args */
> > +#define INTEL_DSM_FN_DP_IN_SWITCH_TO_DGFX 20 /* No args */
> >
> >  static const guid_t intel_dsm_guid2 =
> >         GUID_INIT(0x3e5b41c6, 0xeb1d, 0x4260,
> > @@ -187,6 +188,7 @@ void intel_dsm_get_bios_data_funcs_supported(struct drm_i915_private *i915)
> >         struct pci_dev *pdev = to_pci_dev(i915->drm.dev);
> >         acpi_handle dhandle;
> >         union acpi_object *obj;
> > +       int supported = 0;
> >
> >         dhandle = ACPI_HANDLE(&pdev->dev);
> >         if (!dhandle)
> > @@ -194,8 +196,22 @@ void intel_dsm_get_bios_data_funcs_supported(struct drm_i915_private *i915)
> >
> >         obj = acpi_evaluate_dsm(dhandle, &intel_dsm_guid2, INTEL_DSM_REVISION_ID,
> >                                 INTEL_DSM_FN_GET_BIOS_DATA_FUNCS_SUPPORTED, NULL);
> > -       if (obj)
> > +       if (obj) {
> > +               if (obj->type == ACPI_TYPE_INTEGER)
> > +                       supported = obj->integer.value;
> > +
> >                 ACPI_FREE(obj);
> > +       }
> > +
> > +       /* Tiger Lake H DP-IN Boot Time Switching from iGfx to dGfx */
> > +       if (supported & BIT(20)) {
> > +               obj = acpi_evaluate_dsm(dhandle, &intel_dsm_guid2,
> > +                                       INTEL_DSM_REVISION_ID,
> > +                                       INTEL_DSM_FN_DP_IN_SWITCH_TO_DGFX,
> > +                                       NULL);
> > +               if (obj)
> > +                       ACPI_FREE(obj);
> > +       }
> >  }
> >
> >  /*
> > --
> > 2.36.1
> >
>
