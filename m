Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24C48524EA1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 15:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354615AbiELNro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 09:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354613AbiELNrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 09:47:42 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED626338A
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 06:47:41 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-d6e29fb3d7so6671520fac.7
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 06:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lAKLw82Wxg+eOurBghu8fJNyA1GqYs5wj0gY1XCz7Ro=;
        b=m/GTkuGjI1B5jx6nL5P/4EflzdI3QMBGmNFCquv0Dxr0fCYznNF6rzRzEHPTPKHxXC
         DXkAKLOzNRwhfxSdESZFpIRvG+4ceQQN+sJ5+0VpUfTCScU4gdBJ9VySZxgLIceicUds
         Ul+KyFqAPUGMw/oPmRPKxvrhebfFVHvbJF+yf079NmUheQb5udeUeydhsXZbaHMmno/M
         tnPkY9nJec+JaKIn08CcOWzb7djbqDDajDyMz/aUcIC+q5F/D4P1UtsbQeBaR5gM8q3D
         eU1114Kx4jWdj/jaaqyOGLuTD+X0YmsNDvim0dLXzohhh4FKhdxtFfSkSxthfQj4E1GD
         89Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lAKLw82Wxg+eOurBghu8fJNyA1GqYs5wj0gY1XCz7Ro=;
        b=uF0cpWqWJaGmOuWrMt1TObgfnEuYlgPiAAu+D0b0ANqnrYczBAF3F97y7c9sRGeycN
         eHwDoNOvlfVwKFOKoo2HwL7KEzx8PUeIDvUjXaIlcbxki6QxGNUspysO31FeqdZIG/+v
         OEmIsvg2kOBzVK36Y6T6vUGqfZWVcDAYT777uTnK8Py18j0Av92n2j6iCyVTTIgph6Fy
         K3A+6+9dKPesMNBLXIfVcglMdQPMByXxC2CmN+gtjryK3ODxIzZUAPJZylaVsxjW2qHb
         ApYzmBZC9ON338CIVfLsykwHnClhia3ja1xQn6PudAAqsUy54zzJGlgFS1k+goiPuLvz
         zY6w==
X-Gm-Message-State: AOAM530dpVv99KpG+zSs6m8WqW5eK33VzlAkBZf6O4T9h2k26O+eoP+1
        cZIUFx9KKrJQiz2/+w45sa9Mr69nLWXr7E/SEeNNueKN
X-Google-Smtp-Source: ABdhPJz3l54A1RhbIxHH695Vm5HWA0Vfm/tkaukXHol2A8LN/cits8d9LpM4S5YTojnhgCH97a8Hlo69iiYpmwq9/30=
X-Received: by 2002:a05:6870:d683:b0:de:eaa2:3550 with SMTP id
 z3-20020a056870d68300b000deeaa23550mr5725345oap.253.1652363260913; Thu, 12
 May 2022 06:47:40 -0700 (PDT)
MIME-Version: 1.0
References: <YnTAc96Uv0CXcGhD@suse.de> <CADnq5_NT3UtawpGuPDwF+dgmRdaoysb7sD_-oWWBC=T3BoUH7Q@mail.gmail.com>
 <YnpIjdTT3esZ72Bf@suse.de> <CADnq5_NYVvjcUru9hfbnATfcHJR5+eiK9bJAA9m41WKa=OJsog@mail.gmail.com>
 <505081FC-4323-4424-87A9-89B95A89515D@suse.de> <CADnq5_PoWLHydAGqHXKNwBnnc_Uz7xc01Mmp2ri-h+RtnRqgfQ@mail.gmail.com>
 <YnzG1KE9tasxdUbX@suse.de>
In-Reply-To: <YnzG1KE9tasxdUbX@suse.de>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 12 May 2022 09:47:29 -0400
Message-ID: <CADnq5_OyfTZ1ma_9rc9ePqhRUqcuNbdCPh7eAYUC7zdX+ZOuyA@mail.gmail.com>
Subject: Re: [BUG] Warning and NULL-ptr dereference in amdgpu driver with 5.18
To:     =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <jroedel@suse.de>
Cc:     "Wentland, Harry" <Harry.Wentland@amd.com>,
        "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
        "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 4:35 AM J=C3=B6rg R=C3=B6del <jroedel@suse.de> wrot=
e:
>
> On Tue, May 10, 2022 at 04:41:57PM -0400, Alex Deucher wrote:
> > Does setting amdgpu.runpm=3D0 on the kernel command line in grub help?
> > If so, that should fixed with:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3Df95af4a9236695caed24fe6401256bb974e8f2a7
>
> Unfortunatly, no, this option doesn't help. Tested with v5.18-rc6, full
> dmesg attached.
>
> Any idea what the BadTLP messages migh be caused by?

Are those new?  Maybe the card is not seated correctly?  Can you try
another slot?

As for the null pointer defer in the display code, @Wentland, Harry
any ideas?  I don't see why that should happen.  Maybe some hotplug
pin is faulty or the display has input detection and that is causing
some sort of hotplug interrupt that causes a race somewhere in the
driver?  Can you make sure the monitor connector is firmly seated on
the GPU?

Alex


>
> Regards,
>
>         Joerg
>
> --
> J=C3=B6rg R=C3=B6del
> jroedel@suse.de
>
> SUSE Software Solutions Germany GmbH
> Maxfeldstr. 5
> 90409 N=C3=BCrnberg
> Germany
>
> (HRB 36809, AG N=C3=BCrnberg)
> Gesch=C3=A4ftsf=C3=BChrer: Ivo Totev
>
