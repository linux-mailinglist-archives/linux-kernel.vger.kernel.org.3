Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE607524D07
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 14:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353571AbiELMgZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 12 May 2022 08:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353803AbiELMgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 08:36:21 -0400
X-Greylist: delayed 93 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 12 May 2022 05:36:18 PDT
Received: from smtprelay05.ispgateway.de (smtprelay05.ispgateway.de [80.67.18.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB27E3A5E1;
        Thu, 12 May 2022 05:36:16 -0700 (PDT)
Received: from [89.1.81.74] (helo=karo-electronics.de)
        by smtprelay05.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <LW@KARO-electronics.de>)
        id 1np80o-00011Z-6Q; Thu, 12 May 2022 14:33:46 +0200
Date:   Thu, 12 May 2022 14:33:30 +0200
From:   Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
To:     Alexandre Bailon <abailon@baylibre.com>
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, matthias.bgg@gmail.com,
        p.zabel@pengutronix.de, rafael@kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        michael.kao@mediatek.com, ben.tseng@mediatek.com,
        ethan.chang@mediatek.com, frank-w@public-files.de,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, khilman@baylibre.com
Subject: Re: [PATCH v6 0/7] Add LVTS architecture thermal
Message-ID: <20220512143330.3d54a71f@karo-electronics.de>
In-Reply-To: <20220512122433.1399802-1-abailon@baylibre.com>
References: <20220512122433.1399802-1-abailon@baylibre.com>
Organization: Ka-Ro electronics GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Df-Sender: bHdAa2Fyby1lbGVjdHJvbmljcy5kb21haW5mYWN0b3J5LWt1bmRlLmRl
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 12 May 2022 14:24:26 +0200 Alexandre Bailon wrote:
> And introduce the new architecture LVTS (low pressure thermal sensor) driver to report
                                      ^        ^
"low voltage"?


Lothar Waßmann
