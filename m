Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 714DE51F3DA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 07:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233871AbiEIF20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 01:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234268AbiEIFZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 01:25:48 -0400
Received: from relay5.hostedemail.com (relay5.hostedemail.com [64.99.140.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFCC9D5CCC;
        Sun,  8 May 2022 22:21:51 -0700 (PDT)
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay09.hostedemail.com (Postfix) with ESMTP id 92F2430168;
        Mon,  9 May 2022 05:20:05 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf20.hostedemail.com (Postfix) with ESMTPA id 9A38C20025;
        Mon,  9 May 2022 05:20:02 +0000 (UTC)
Message-ID: <b2039ae7a9b33b61ea96919da2c53cbc3bca0049.camel@perches.com>
Subject: Re: [PATCH v6 4/4] thermal: k3_j72xx_bandgap: Add the bandgap
 driver support
From:   Joe Perches <joe@perches.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>, kbuild@lists.01.org,
        Keerthy <j-keerthy@ti.com>, robh+dt@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, amitk@kernel.org,
        kristo@kernel.org, vigneshr@ti.com, krzysztof.kozlowski@linaro.org
Cc:     lkp@intel.com, kbuild-all@lists.01.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sun, 08 May 2022 22:20:02 -0700
In-Reply-To: <202205030045.5GxgWkst-lkp@intel.com>
References: <202205030045.5GxgWkst-lkp@intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 9A38C20025
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Stat-Signature: d9zqnyyg63eizau1ckgb9u8dhfubqkb9
X-Rspamd-Server: rspamout01
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/3ca4Q9WkkjlN21HSVOUaQ9HmljpP9naQ=
X-HE-Tag: 1652073602-450815
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-05-04 at 11:00 +0300, Dan Carpenter wrote:
> Hi Keerthy,
[]
> vim +/ref_table +521 drivers/thermal/k3_j72xx_bandgap.c
[]
> bb7f95a68cbaa1 Keerthy 2022-04-27  426  	ref_table = kzalloc(sizeof(*ref_table) * TABLE_SIZE, GFP_KERNEL);
> bb7f95a68cbaa1 Keerthy 2022-04-27  427  	if (!ref_table) {
> bb7f95a68cbaa1 Keerthy 2022-04-27  428  		ret = -ENOMEM;
> bb7f95a68cbaa1 Keerthy 2022-04-27  429  		goto err_alloc;
> bb7f95a68cbaa1 Keerthy 2022-04-27  430  	}

devm_kcalloc

> bb7f95a68cbaa1 Keerthy 2022-04-27  431  
> bb7f95a68cbaa1 Keerthy 2022-04-27  432  	derived_table = devm_kzalloc(bgp->dev, sizeof(*derived_table) * TABLE_SIZE,
> bb7f95a68cbaa1 Keerthy 2022-04-27  433  				     GFP_KERNEL);

here too


