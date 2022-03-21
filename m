Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D19FD4E3309
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 23:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbiCUWsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 18:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiCUWsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 18:48:12 -0400
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34FE23A592C;
        Mon, 21 Mar 2022 15:28:29 -0700 (PDT)
Received: by mail-ot1-f54.google.com with SMTP id 17-20020a9d0611000000b005b251571643so11450201otn.2;
        Mon, 21 Mar 2022 15:28:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P30I1IvBZVWzxnjjs8xKnvlDjjaGWLFseUJUE0t0iug=;
        b=CrB+tMlFpjHTSXg8Gn2v8DWc7jPVjtUqLQ9CAHIZh1fY/0P633UHu7U/0Bgi+Vga5r
         rXzASm9uKs403Y8WSjJxCkCoE1K2PUlGnTahtR919klWYuRFFt6NLob7hPejQCwjt3A0
         0cIrdgZ2UqBn876GtK8jo1s/kEL+AAA1UQTwhadZiDVPFykLBLLNNI56gVUM45Q4P9UH
         64B+VHllK1G8OLxgF7PvAiNNXcpDQ0R5CV2U3HFljF1w0/K6QP7cevdJ829zuPMpXhwz
         eyUL9GVLyu2uQ1cVR4QvhdPmXpkZ2uxEXLIv276wE1KqKW63BLkBsTeA+a5Kjia8DYwI
         ne3A==
X-Gm-Message-State: AOAM531ueoXZTkDMZaXw19ZulsYy/Wn4v3gJdLINOB6vzhYvD3aZrH7U
        L2bJCzDjY3uA6txGvtldaA==
X-Google-Smtp-Source: ABdhPJwhjaMdN3trRKuth/6PhzKCiyCDabep5R8B9rofsON9bTADl679fotxe+oPsBcjqvQOnCb4+Q==
X-Received: by 2002:a9d:7994:0:b0:5b2:3110:e69c with SMTP id h20-20020a9d7994000000b005b23110e69cmr8812492otm.267.1647901708497;
        Mon, 21 Mar 2022 15:28:28 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g8-20020acab608000000b002ecf38fb699sm8030714oif.38.2022.03.21.15.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 15:28:27 -0700 (PDT)
Received: (nullmailer pid 653541 invoked by uid 1000);
        Mon, 21 Mar 2022 22:28:25 -0000
Date:   Mon, 21 Mar 2022 17:28:25 -0500
From:   Rob Herring <robh@kernel.org>
To:     Moudy Ho <moudy.ho@mediatek.com>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-media@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Ping-Hsun Wu <ping-hsun.wu@mediatek.com>, tfiga@chromium.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        jason-jh.lin@mediatek.com, river.cheng@mediatek.com,
        linux-kernel@vger.kernel.org, roy-cw.yeh@mediatek.com,
        srv_heupstream@mediatek.com,
        Jernej Skrabec <jernej.skrabec@siol.net>, pihsun@chromium.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, hsinyi@google.com,
        linux-arm-kernel@lists.infradead.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        daoyuan huang <daoyuan.huang@mediatek.com>,
        randy.wu@mediatek.com,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        allen-kh.cheng@mediatek.com, sj.huang@mediatek.com,
        linux-mediatek@lists.infradead.org, drinkcat@chromium.org,
        menghui.lin@mediatek.com,
        Alexandre Courbot <acourbot@chromium.org>,
        Rob Landley <rob@landley.net>
Subject: Re: [PATCH v14 3/6] dt-bindings: soc: mediatek: move out common
 module from display folder
Message-ID: <Yjj8CanzmdHeX7qz@robh.at.kernel.org>
References: <20220317143926.15835-1-moudy.ho@mediatek.com>
 <20220317143926.15835-4-moudy.ho@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220317143926.15835-4-moudy.ho@mediatek.com>
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

On Thu, 17 Mar 2022 22:39:23 +0800, Moudy Ho wrote:
> In order to share the same hardware information with MDP3,
> change the MUTEX dt-binding to the path "soc/mediatek".
> 
> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
> ---
>  .../bindings/{display => soc}/mediatek/mediatek,mutex.yaml      | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>  rename Documentation/devicetree/bindings/{display => soc}/mediatek/mediatek,mutex.yaml (97%)
> 

Acked-by: Rob Herring <robh@kernel.org>
