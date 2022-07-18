Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7B065789B9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 20:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236028AbiGRSoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 14:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236046AbiGRSoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 14:44:18 -0400
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E8EDE9A;
        Mon, 18 Jul 2022 11:44:14 -0700 (PDT)
Received: by mail-io1-f44.google.com with SMTP id n138so8763725iod.4;
        Mon, 18 Jul 2022 11:44:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xT29dFQG9gO6zUOkC6HwFgLGzT9S34ngMonC+QSf2Mg=;
        b=uCMqmlWqj0BietQUYb+YYdjAHxw5dNj1l8Xj706tDUjWZT4P36irDjqNEZQMFOpd++
         g6fi3esd8cENAuAq37OufWYxWpoGdCFMHh9WCfZ34U58F4WuYdDn3hX0r65B5edcUW8A
         s4G6L5uSIZYJdvc7j5ZsuHb/0PTb3ZDug/jV0U6ZfkaeC0jQWmQVwntO/j4rKjVxanjK
         rH6Pxo9oFjc7GqR/YrMSnPw5SvfExEmw7THeiE+T59v+GTR6NojFi+VhOMhn6aN90WP7
         89sKTjX+V1amoiFTKhdnkTbmg/qPsRCZX3ivyYt6K0greOFteaPUaX/GkTy5c59xSZ3a
         9tmA==
X-Gm-Message-State: AJIora9vV5LV3NSm+mOBkz4gtoSx+TQsgMys248A00YmERKGtKsj6dpK
        sz8hs9A4UkLfq+9KCtLAVCS+cwPrmA==
X-Google-Smtp-Source: AGRyM1s6VYhtM8AfinB2gMgIvElLBBuNUg5GEn+jv3VioD1/E3fdRmV5D0aWKyrIxBqsnn62hvzymw==
X-Received: by 2002:a05:6638:272c:b0:33f:6fe4:b76f with SMTP id m44-20020a056638272c00b0033f6fe4b76fmr14884160jav.284.1658169853769;
        Mon, 18 Jul 2022 11:44:13 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id g26-20020a05663810fa00b00339d244c4a6sm5876544jae.23.2022.07.18.11.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 11:44:13 -0700 (PDT)
Received: (nullmailer pid 3326217 invoked by uid 1000);
        Mon, 18 Jul 2022 18:44:11 -0000
Date:   Mon, 18 Jul 2022 12:44:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     Xiandong Wang <xiandong.wang@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-mediatek@lists.infradead.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v2 1/2] dt-bindings: soc: mediatek: add mdp3 mutex
 support for mt8186
Message-ID: <20220718184411.GA3326033-robh@kernel.org>
References: <20220711123247.15807-1-allen-kh.cheng@mediatek.com>
 <20220711123247.15807-2-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220711123247.15807-2-allen-kh.cheng@mediatek.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Jul 2022 20:32:46 +0800, Allen-KH Cheng wrote:
> Add mdp3 mutex compatible for mt8186 SoC.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> Signed-off-by: Xiandong Wang <xiandong.wang@mediatek.com>
> ---
>  .../devicetree/bindings/soc/mediatek/mediatek,mutex.yaml         | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
