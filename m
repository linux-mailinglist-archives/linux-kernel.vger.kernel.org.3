Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561D44E472D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 21:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232656AbiCVUEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 16:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232601AbiCVUEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 16:04:47 -0400
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF5C27CD2;
        Tue, 22 Mar 2022 13:03:19 -0700 (PDT)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-dacc470e03so2806869fac.5;
        Tue, 22 Mar 2022 13:03:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Fq1z4Ed84ZuWdkW2m9jYI7sM6QJam+q9K1arrVbgWws=;
        b=HzR5KHgBJZX4QzPydA7vo7tY9/5VR+Qlv6HaHpazIh6RFMoxebS3ta9FfLDdSuwND8
         Z/Wx3x3aoEUANdoZVkyiDCVE9uMuX1fVVLdk6lKwpAg169tqEV4jdUJaFcLL0Tt1mlns
         NGzJsH7jR7wh52GrblG+84WVAmt/9hhVCFMpplAtlXk8fm8SjK3FhyP3l5hxC0eEYyQJ
         5zC/htQuWWr9vGvI7v66lWPV3E5w2HP4qgF2ukU6EQNZ+WD/rEZusb+ZQaZWh0Z0y0M4
         y3u/KRCHQ7LGWetFY/9QOfQVoCokx7qQPt79oT0BZml4dWkKdWvjUD9G0dOXq4ZivxyP
         nThw==
X-Gm-Message-State: AOAM532gito9orADE27tNf+NTmoF6qX6Ta8Np5UIzCjAiQq2DTN/Kpvj
        LGpkQNrYC6KvWLogMrCZiw==
X-Google-Smtp-Source: ABdhPJy4AIzdw7CM09sm8WiJu7yAMWYZnT7kqu9E09l5bnyx+c0wfi4rPWwDeKMKI6b9WUwXAQwTQQ==
X-Received: by 2002:a05:6870:b52c:b0:dd:ddfa:3161 with SMTP id v44-20020a056870b52c00b000ddddfa3161mr2430238oap.61.1647979398908;
        Tue, 22 Mar 2022 13:03:18 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 21-20020a056870115500b000dda3a0cb91sm3110524oag.54.2022.03.22.13.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 13:03:17 -0700 (PDT)
Received: (nullmailer pid 2415318 invoked by uid 1000);
        Tue, 22 Mar 2022 20:03:15 -0000
Date:   Tue, 22 Mar 2022 15:03:15 -0500
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
Subject: Re: [PATCH v11 5/7] dt-bindings: display: Add Loongson display
 controller
Message-ID: <Yjorg4taoTVAr8ML@robh.at.kernel.org>
References: <20220321162916.1116541-1-15330273260@189.cn>
 <20220321162916.1116541-6-15330273260@189.cn>
 <YjkITWpbnCmhKaX+@robh.at.kernel.org>
 <f7eb61bc-6784-c77a-083f-7408c0a17e05@189.cn>
 <66ae2436-aa86-f583-85b4-d652273188e9@flygoat.com>
 <629311ac-f847-dd57-689e-eaa97aae8480@189.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <629311ac-f847-dd57-689e-eaa97aae8480@189.cn>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 09:54:08PM +0800, Sui Jingfeng wrote:
> 
> On 2022/3/22 21:08, Jiaxun Yang wrote:
> > 
> > 
> > 在 2022/3/22 2:33, Sui Jingfeng 写道:
> > > 
> > > On 2022/3/22 07:20, Rob Herring wrote:
> > > > On Tue, Mar 22, 2022 at 12:29:14AM +0800, Sui Jingfeng wrote:
> > > > > From: suijingfeng <suijingfeng@loongson.cn>
> > > > > 
> > > > Needs a commit message.
> > > > 
> > > > > Signed-off-by: suijingfeng <suijingfeng@loongson.cn>
> > > > > Signed-off-by: Sui Jingfeng <15330273260@189.cn>
> > > > Same person? Don't need both emails.
> > > 
> > > Yes,  suijingfeng@loongson.cn is my company's email. But it can not
> > > be used to send patches to dri-devel,
> > > 
> > > when send patches with this email, the patch will not be shown on
> > > patch works.
> > > 
> > > Emails  are either blocked or got  rejected  by loongson's mail
> > > server.  It can only receive emails
> > > 
> > > from you and other people, but not dri-devel. so have to use my
> > > personal email(15330273260@189.cn) to send patches.
> > In this case you can just use your company's email to sign-off
> > code and sending with your personal email. It's common practice.
> > 
> > If you don't want to receiving kernel email in your company mailbox,
> > you can add a entry in .mailmap .
> > 
> |I'm using `git send-email -7 --cover-letter --annotate -v11` command to
> send patches, it will automatically sign off patches with the my private
> emails. |

I think that is only if you set your git config author to your private 
email. Pretty much anything git might automatically do can be turned 
off.

Rob

