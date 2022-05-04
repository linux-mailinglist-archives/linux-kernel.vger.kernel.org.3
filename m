Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D63251AC41
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 20:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376585AbiEDSIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 14:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376328AbiEDSIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 14:08:12 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA70C7092E;
        Wed,  4 May 2022 10:23:30 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 65AF91C0BBB; Wed,  4 May 2022 19:23:29 +0200 (CEST)
Date:   Wed, 4 May 2022 19:23:28 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Caleb Connolly <caleb.connolly@linaro.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Amit Pundir <amit.pundir@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>
Subject: Re: [PATCH 0/6] power: supply: introduce support for the Qualcomm
 smb2 charger
Message-ID: <20220504172328.GC1623@bug>
References: <20220427184031.2569442-1-caleb.connolly@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427184031.2569442-1-caleb.connolly@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Add a driver for the Qualcomm PMI8998/PM660 Switch-Mode Battery Charger.
> This is the second generation SMB charger, and replaces the previous
> SMBB hardware found in older PMICs.
> 
> This driver provides basic support for initialising the hardware,
> configuring the USB input current limit and reporting information about
> the state of the charger. Features like type-c dual role support and OTG
> switching will be added in future patches.
> 
> This patch series depends on my previous series adding support for
> the Round Robin ADC which is used for reading the USB voltage and
> current, it can be found here:
> https://lore.kernel.org/linux-arm-msm/20220323162820.110806-1-caleb@connolly.tech/

Please cc phone-devel mailing list with this and related stuff.

Best regards,
									Pavel
