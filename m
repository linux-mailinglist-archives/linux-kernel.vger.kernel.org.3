Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6433F4E528A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 13:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243354AbiCWMyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 08:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231730AbiCWMym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 08:54:42 -0400
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1BDBF64;
        Wed, 23 Mar 2022 05:53:10 -0700 (PDT)
Received: by mail-ot1-f48.google.com with SMTP id n19-20020a9d7113000000b005cd9cff76c3so1006967otj.1;
        Wed, 23 Mar 2022 05:53:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=NuW/5LjLTYnCe1iEVLuiQEgZKBilhYbTzhjTvpjmYV8=;
        b=hB7CgeuEorWcn1e75KA2rscuAeN+GIv0P4siifcmpWxoUvjkR0Fp+dgB21p0io0hwg
         lghVZkCJ/JVzYKkMlR0WscYIyzmDsEVvl0CMQQOvX4QMie3a48sQXm38GMGC2iq7GonE
         oknxiOYPL4HHVs0U1f7+lBVyRM6AyhxJ84LhVG2Jh5oxfW7ZLIR8/rNgMXwlW/GMw5To
         dAYa2YnH9WaoW9lgBzHUO0kQU57oVWJSTWT+BpoIaXK65+E/I+4DKugWdMCt2f1097Ft
         U/HPR8VJWJ46y4a3w1lwB67g1CnFaeRHIzWdIe0UnwBlDWZeGVySO4a4SE43C+LCPwiu
         e3tQ==
X-Gm-Message-State: AOAM532xudJEvYDYcJuO+oLDFXh2w0dapdP33xGeS8xRp5Tva6Rm+pcc
        QgNJGDNb3dX/u1NJO6dikg==
X-Google-Smtp-Source: ABdhPJxBqvzQfjrGlAOysJzMPqRkTSzE0/WIGGYcR37p7UXxuOVZQTdDAxfHMh5kUojrSrUi6QncEg==
X-Received: by 2002:a05:6830:2010:b0:5b2:38da:6c24 with SMTP id e16-20020a056830201000b005b238da6c24mr11651996otp.158.1648039989736;
        Wed, 23 Mar 2022 05:53:09 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p4-20020a056870a54400b000da07609a6dsm8601476oal.22.2022.03.23.05.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 05:53:08 -0700 (PDT)
Received: (nullmailer pid 3908190 invoked by uid 1000);
        Wed, 23 Mar 2022 12:53:07 -0000
Date:   Wed, 23 Mar 2022 07:53:07 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sui Jingfeng <15330273260@189.cn>
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Roland Scheidegger <sroland@vmware.com>,
        Zack Rusin <zackr@vmware.com>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        "David S . Miller" <davem@davemloft.net>,
        Lucas Stach <l.stach@pengutronix.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        Qing Zhang <zhangqing@loongson.cn>,
        suijingfeng <suijingfeng@loongson.cn>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v11 2/7] MIPS: Loongson64: dts: introduce ls3A4000
 evaluation board
Message-ID: <YjsYM0M24VhkCHwG@robh.at.kernel.org>
References: <20220321162916.1116541-1-15330273260@189.cn>
 <20220321162916.1116541-3-15330273260@189.cn>
 <2644866a-8db2-923e-4227-2aa6d8e375fe@flygoat.com>
 <2c671752-6684-f87b-7b2d-90568d36adde@189.cn>
 <005099b5-33ed-4cb7-f8e4-10e1de780311@flygoat.com>
 <abe784ce-eb9e-0143-dbc3-d415bbedbb81@189.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <abe784ce-eb9e-0143-dbc3-d415bbedbb81@189.cn>
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

On Wed, Mar 23, 2022 at 09:53:14AM +0800, Sui Jingfeng wrote:
> 
> On 2022/3/23 00:06, Jiaxun Yang wrote:
> > 
> > 
> > 在 2022/3/22 13:38, Sui Jingfeng 写道:
> > > 
> > > On 2022/3/22 21:05, Jiaxun Yang wrote:
> > > > 
> > > > 
> > > > 在 2022/3/21 16:29, Sui Jingfeng 写道:
> > > > > From: suijingfeng <suijingfeng@loongson.cn>
> > > > > 
> > > > > The board name is LS3A4000_7A1000_EVB_BOARD_V1.4, it consist of 1.8Ghz
> > > > > mips64r5 4-core CPU and LS7A1000 bridge chip. It has PCIe
> > > > > GEN2 x8 slot,
> > > > > therefore can play with discrete graphics card.
> > > > 
> > > > Hi Jingfeng,
> > > > 
> > > > As we've discussed before if you are going to introduce new dts
> > > > then you *MUST*
> > > > include it in makefile and wire it up in code.
> > > > 
> > > > A dts file doing nothing lying in the tree is just suspicious.
> > > > 
> > > > Thanks.
> > > > - Jiaxun
> > > > 
> > > Hi, Jiaxun,
> > > 
> > > I know what you means, but it is the kernel side developer's job.
> > > I am just a naive graphic driver developer,I can not care so much.
> > > Below is my private patch which can be used to built specific dts
> > > into the linux kernel, therefore make the verification easier.
> > Hi Jingfeng,
> > 
> > In kernel world we take care all the stuff we touched ourself :-)
> > 
> > If you are not confident with them please drop those DTS from the
> > patchset
> > besides the generic one. I can do the rest for you after getting this
> > set merged.
> > 
> > Thanks.
> > - Jiaxun
> > 
> Hi, Jiaxun
> 
> Build all dts into vmlinuz will make the vmlinuz bigger and bigger.
> How does the kernel get the dtb is another big issue, either from built-in
> dtb or pass from the firmware(pmon and uefi etc). This should be
> solved with another patch carefully. Providing board specific dts
> helps to code review, it helps reviewers understand that there are
> variant boards and have to be express with different OF graph.

Built-in DTBs are for legacy bootloaders that don't understand DT. I 
would not expect a new platform to need this.

> 
> Now, there are about 6 dts under arch/mips/boot/dts/loongson/,
> Suppose loongson have 1000+ different board, do you want built all
> of them into vmlinuz?

The point was to add the .dts to Makefile so it builds, not so it is 
built-in. How are you testing those build with dtc and dtschema if not 
added to kbuild?

Rob
