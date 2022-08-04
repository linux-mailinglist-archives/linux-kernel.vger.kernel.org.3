Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7B3C58A2EE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 23:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239609AbiHDVyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 17:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239733AbiHDVxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 17:53:54 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126F318342
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 14:53:52 -0700 (PDT)
Date:   Thu, 04 Aug 2022 21:53:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1659650027; x=1659909227;
        bh=y4kH6rqMb1GQXexTQtqvrxt2lPMXsfbG1mA+tOI739c=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
         Feedback-ID:Message-ID;
        b=wM9wd65TfEblAUDKRbzgTQvO3TV4GZxemmJjMEH1Cz5y6ECqepuDQVdgMESpvifyD
         gXshbM8wh7P1p8UYqRv4Nfrn8H8oWCpz+3Q8CC2pq5GzOk5k2hDvZa9vLMpfOmwwIo
         oIwmG5SazSMYhH9bMc/HXXwlSPLB3TXZd5d/ZrXrrYPmMGQw0bzwPsekUq4zrOrPDo
         roHQ8fQpjRKH+jGseZqZej5DRHia1fXKlhrTcEQlE+biBtQWbH0EsiWi+pyu+kzD10
         ZzHKO6wob5s/R676oDfF4AmVU7tyHtgHcLSkdr7UwgwYHZColKGUOCDV/w2Th+Xwdz
         rPELh2wEWCY1g==
To:     Hans de Goede <hdegoede@redhat.com>
From:   =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc:     "Luke D. Jones" <luke@ljones.dev>, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Reply-To: =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Subject: Re: [PATCH v2 1/1] asus-wmi: Add support for TUF laptop keyboard states
Message-ID: <ybhjXWmB07-FDJ_Shcl8d3jd7Y6SJdoQ1XPQrxe1q6MVogS6BaYdjkf-g9DAdXWvfmmemMVGWk9t34LDhiJTFidhVXkkfOwXHMNx-f1Vgq0=@protonmail.com>
In-Reply-To: <db7f33c8-404d-6e41-73af-370e148a4eed@redhat.com>
References: <20220803231331.48788-1-luke@ljones.dev> <20220803231331.48788-2-luke@ljones.dev> <db7f33c8-404d-6e41-73af-370e148a4eed@redhat.com>
Feedback-ID: 20568564:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans


2022. augusztus 4., cs=C3=BCt=C3=B6rt=C3=B6k 15:22 keltez=C3=A9ssel, Hans d=
e Goede <hdegoede@redhat.com> =C3=ADrta:

> [...]
> Please make this an extra attribute for the led_class_device,
> you can do this by adding this attribute to a separate
> attribute_group, lets say e.g. "tuf_rgb_attributes" and then
> in the "[PATCH] asus-wmi: Add support for TUF laptop keyboard RGB"
> code add:
>
> =09mc_cdev->led_cdev.groups =3D tuf_rgb_attributes;
>
> and then the "tuf_krgb_state" file should show up as:
> /sys/class/leds/asus::multicolour/tuf_krgb_state

I am not sure this will work because `led_classdev_multicolor_register_ext(=
)`
overrides the embedded LED device's `led_classdev::groups` with
`led_multicolor_groups` to provide the multi-color functionality
before calling `led_classdev_register_ext()`.


> [...]


Regards,
Barnab=C3=A1s P=C5=91cze
