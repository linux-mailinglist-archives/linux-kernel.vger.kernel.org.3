Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D29F152A91F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 19:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239785AbiEQRXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 13:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbiEQRW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 13:22:59 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0614B26547;
        Tue, 17 May 2022 10:22:57 -0700 (PDT)
Received: from mail.denx.de (unknown [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: festevam@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 5CDAD80563;
        Tue, 17 May 2022 19:22:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1652808175;
        bh=J5dyxFbiFJCvDNdMNQhoyLESCKTEEO8zaqvRFwMD1lM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HuBu/6hLkMHrC5q2SIRzRKM+VReiQhTkq43f68CO6DDvl/YFLbiyiVbdzdvBuUlL4
         FJXumjPJ5Ep9MYZGT7q7aN0HwBuWQb9FEPg6hTWdgkspaRUcWNfCpjnuGpdl/EFcYf
         wo0n20aP630bS9H9FbzfJWkx39WpIGXgDXePisQ9dZ5Ojx0s6EbWOQwP08/xy3lNoG
         UfFXAJlhCRADJkGB3lGyppm/zLkLNTd6GcL2giqH1bjkp0Xtc7dMehaFeyalDr0Suf
         T1l1IwB04QghmaKGh9J+nxrNEluCYvxuVSfFisXTW+ToEqfi7CUGJOIIyfh1y5kou+
         5sU61TGbghhjQ==
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 17 May 2022 14:22:55 -0300
From:   Fabio Estevam <festevam@denx.de>
To:     Michael Trimarchi <michael@amarulasolutions.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-amarula@amarulasolutions.com,
        Rob Herring <robh+dt@kernel.org>,
        Ariel D'Alessandro <ariel.dalessandro@collabora.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Simon Holesch <simon.holesch@bshg.com>
Subject: Re: [PATCH V2] arm: dts: imx6ulz-bsh-smm-m2: Support proper board
 power off
In-Reply-To: <20220517135342.2458267-1-michael@amarulasolutions.com>
References: <20220517135342.2458267-1-michael@amarulasolutions.com>
Message-ID: <103ffb04dc36c66112deaae7566b1622@denx.de>
X-Sender: festevam@denx.de
User-Agent: Roundcube Webmail/1.3.6
X-Virus-Scanned: clamav-milter 0.103.5 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/05/2022 10:53, Michael Trimarchi wrote:
> From: Simon Holesch <simon.holesch@bshg.com>
> 
> Supports initiating poweroff on SNVS_PMIC_ON_REQ signal.
> 
> Signed-off-by: Simon Holesch <simon.holesch@bshg.com>
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>

Reviewed-by: Fabio Estevam <festevam@denx.de>
