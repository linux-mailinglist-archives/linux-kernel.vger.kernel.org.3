Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F04F34AFFF2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 23:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235146AbiBIWOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 17:14:23 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:36598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235126AbiBIWOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 17:14:14 -0500
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC541E015253;
        Wed,  9 Feb 2022 14:14:13 -0800 (PST)
Received: by mail-oi1-f176.google.com with SMTP id m10so4063960oie.2;
        Wed, 09 Feb 2022 14:14:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5w3QoXmnLsihgEA/Et9MpIi6nloh2mbWHhlRSc4SJVU=;
        b=fMz3x7ZDfNsSK72Zh3Qd99TfJ4MsQ1hMucgMv9K4hnnBsqACcDPJPFNERj8ElEkO22
         JvWzLwwHs1Sw3FtypybNyb9DMYsZhs6gN3JkFFv7E9BWqsGOZ8/OcjpafCTCSjZeLqP4
         96t7qpkueIs2SNKlcPpFVqZqr/LfGuoa+cO4CR3pspRvZHv6Pyk8sqbi+Kz4X0TJNFp+
         mbtl56pLWiZfNcAQ6rue9Oy1vZvDwsZTrdhY6cMHCTlVo3X+TfwwwygMuPDaj3wMTfzh
         2M24rpHZEJ/MFqTjmXLa5uQHsfYRoP4A9hqasluzUpZPvkRKWrOuVYo1qFws80UEge06
         GfsA==
X-Gm-Message-State: AOAM533p1Zyy1F5F5iGchp132iCXFB1yaucjvvFDPq4nUaFQcem+rVw+
        YZr2c/3i3JIZErOg+Wn2Bg==
X-Google-Smtp-Source: ABdhPJzweqXLNVP7+tC8UIOfrH2IH0wKhXWBXS/zBWs578C+quPBmzcGsHsOdY/vYUi67D0BCYkOXw==
X-Received: by 2002:a54:488c:: with SMTP id r12mr2027834oic.104.1644444852983;
        Wed, 09 Feb 2022 14:14:12 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id f21sm7069506otq.4.2022.02.09.14.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 14:14:12 -0800 (PST)
Received: (nullmailer pid 1028963 invoked by uid 1000);
        Wed, 09 Feb 2022 22:14:11 -0000
Date:   Wed, 9 Feb 2022 16:14:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-fbdev@vger.kernel.org, Maxime Ripard <maxime@cerno.tech>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        David Airlie <airlied@linux.ie>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 4/4] dt-bindings: display: ssd1307fb: Add myself as
 binding co-maintainer
Message-ID: <YgQ8s5S3mqYMPyqW@robh.at.kernel.org>
References: <20220204134347.1187749-1-javierm@redhat.com>
 <20220204134347.1187749-5-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204134347.1187749-5-javierm@redhat.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 04 Feb 2022 14:43:47 +0100, Javier Martinez Canillas wrote:
> The ssd130x DRM driver also makes use of this Device Tree binding to allow
> existing users of the fbdev driver to migrate without the need to change
> their Device Trees.
> 
> Add myself as another maintainer of the binding, to make sure that I will
> be on Cc when patches are proposed for it.
> 
> Suggested-by: Sam Ravnborg <sam@ravnborg.org>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
> 
> (no changes since v1)
> 
>  Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
