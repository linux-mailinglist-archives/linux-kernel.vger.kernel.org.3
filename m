Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0574451791C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 23:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387656AbiEBVak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 17:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387638AbiEBVag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 17:30:36 -0400
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA8ADFBC;
        Mon,  2 May 2022 14:27:05 -0700 (PDT)
Received: by mail-ot1-f52.google.com with SMTP id 31-20020a9d0822000000b00605f1807664so7467744oty.3;
        Mon, 02 May 2022 14:27:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EsdfTRzRsElhBArWgPiV5kB/wKpIPZn5Ogj7LhGJATU=;
        b=5xbPRkNekYWfHQaKZ2RBdB87XoUOG/qdpJ41bJEdlX3xU5E54tb3jhJfHiXZNR+Jst
         i5GeL7yMrokLVbXdW8QLP8ARA5oeKdSTZTaxKTs2T6ZOm8kxI62/ZLfSWM0/ILYs1ndz
         ZO+8PnYwAvGJnLj5dn56kFitZM2wsfjiHBKpNnhZTzUCZXP8VHfqUElafMBMf56zyDBv
         ijjTrFFdkTxS/VcaDl4kqPOgKB/MUyv848Ac2QWt5fwHtgYv44UEwaeo9eqvkwDn8kzL
         IxIfvs4gRTbf63LQi2OGSO/ArRdH8QzMDBnasYmqUpOMFc1EXeXEwLAhdsFVGjMClH8r
         Sdvw==
X-Gm-Message-State: AOAM532/I5BFdwwnORuIHsngsgMs6sjCNQSX343hcNQmkOmYj+0P03XB
        dHsM5DVQCw8JG+eX/GBagQ==
X-Google-Smtp-Source: ABdhPJxkBlKrm6SvtSp+hLxpW9sfD1oaQcy4xBqkj3dJZ98/SwK51i5iypx4zzQa3BHjub2l6y5/TQ==
X-Received: by 2002:a9d:172f:0:b0:606:31ed:5d86 with SMTP id i47-20020a9d172f000000b0060631ed5d86mr471566ota.266.1651526824990;
        Mon, 02 May 2022 14:27:04 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w5-20020a9d70c5000000b0060603221268sm3254695otj.56.2022.05.02.14.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 14:27:04 -0700 (PDT)
Received: (nullmailer pid 1784930 invoked by uid 1000);
        Mon, 02 May 2022 21:27:03 -0000
Date:   Mon, 2 May 2022 16:27:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     robh+dt@kernel.org, etienne.carriere@st.com,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Marek Vasut <marex@denx.de>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>, arnd@arndb.de,
        soc@kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH 4/8] dt-bindings: reset: stm32mp15: rename RST_SCMI define
Message-ID: <YnBMp27tB1774s/L@robh.at.kernel.org>
References: <20220422150952.20587-1-alexandre.torgue@foss.st.com>
 <20220422150952.20587-5-alexandre.torgue@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422150952.20587-5-alexandre.torgue@foss.st.com>
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

On Fri, 22 Apr 2022 17:09:48 +0200, Alexandre Torgue wrote:
> As we only have one SCMI instance, it's not necessary to add an index to
> the name.
> 
> Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
> 

Acked-by: Rob Herring <robh@kernel.org>
