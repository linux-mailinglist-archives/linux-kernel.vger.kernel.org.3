Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69BA64D6433
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 15:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344507AbiCKPAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 10:00:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245606AbiCKPAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 10:00:15 -0500
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE37E159EA1;
        Fri, 11 Mar 2022 06:59:12 -0800 (PST)
Received: by mail-oo1-f50.google.com with SMTP id s203-20020a4a3bd4000000b003191c2dcbe8so10747056oos.9;
        Fri, 11 Mar 2022 06:59:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rlx1JW7lygTQGtLeTLatrd0STmwHhSb7akSrp1qNp2c=;
        b=DN3kgfpKDdRfC9iKXPqWD0tGSoY48fjO+mS3wV9agp0gA4wotzXuA61JJWN05PquAo
         3NbJ9Rzd++OsO51l6EvtuaHRlpk5AQWrpaq+gF4BQQ5BEbTfDiJnRbnDtIkCR0bYdu1b
         J+fevQhgOMyyWO4JN2dlxvv+uQiMNLmQsnoS06EEXELQS+5qIZuJAZnG1dngq0auXmep
         fr2QL/2JrnNHgTjVHvQyIptGtnJoTasjESqd//B4AeBgT6gcXFbaCbRO5INYR9RI60kQ
         +rvIiitUeKtrtDmvz1auAj3+/uayplzaasPKhWuf/8caVYNLNrxCNKO3eRWWbC3weFgj
         mJxA==
X-Gm-Message-State: AOAM5307a5J/+CfCSdpLm1Fd1HrjBCZS+karuXflRLoDg/m7sUFMDhrm
        J2l1VSNXaJXx6PznLyHrvg==
X-Google-Smtp-Source: ABdhPJzZqlxXCEjPjvwipUL3ApHB6wT089kVO6hV+r1oOvdK0tXoMUA9ddqGUbwnSZzC8ucRGYnOeg==
X-Received: by 2002:a05:6870:6024:b0:da:b3f:3207 with SMTP id t36-20020a056870602400b000da0b3f3207mr5574789oaa.183.1647010751924;
        Fri, 11 Mar 2022 06:59:11 -0800 (PST)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 4-20020a056870004400b000dabe0c435bsm1483240oaz.7.2022.03.11.06.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 06:59:11 -0800 (PST)
Received: (nullmailer pid 3783608 invoked by uid 1000);
        Fri, 11 Mar 2022 14:59:10 -0000
Date:   Fri, 11 Mar 2022 08:59:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Christophe Branchereau <cbranchereau@gmail.com>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 4/4] dt-bindings: display/panel: Add Leadtek
 ltk035c5444t
Message-ID: <YitjvmxpKHARVcYk@robh.at.kernel.org>
References: <20220311120453.163297-1-cbranchereau@gmail.com>
 <20220311120453.163297-5-cbranchereau@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220311120453.163297-5-cbranchereau@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2022 at 01:04:53PM +0100, Christophe Branchereau wrote:
> Add binding for the leadtek ltk035c5444t, which is a 640x480
> mipi-dbi over spi / 24-bit RGB panel based on the newvision
> NV03052C chipset.
> 
> It is found in the Anbernic RG350M mips handheld.
> 
> Signed-off-by: Christophe Branchereau <cbranchereau@gmail.com>
> ---
>  .../display/panel/leadtek,ltk035c5444t.yaml   | 59 +++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/leadtek,ltk035c5444t.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/leadtek,ltk035c5444t.yaml b/Documentation/devicetree/bindings/display/panel/leadtek,ltk035c5444t.yaml
> new file mode 100644
> index 000000000000..9e728f8ce0cd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/leadtek,ltk035c5444t.yaml
> @@ -0,0 +1,59 @@
> +# SPDX-License-Identifier: GPL-2.0

Why did you change the license? It was correct before.

Rob
