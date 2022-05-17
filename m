Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24CFA52A3B0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 15:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347997AbiEQNmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 09:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348137AbiEQNlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 09:41:31 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89DF183B9;
        Tue, 17 May 2022 06:41:29 -0700 (PDT)
Received: from mail.denx.de (unknown [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: festevam@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 5806580762;
        Tue, 17 May 2022 15:41:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1652794887;
        bh=zbcQGbZS5AQ0KRI+idVh1qeEtKHtQw7LjdFgVa3rRLc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=G2c9JyOsy5CSEQzMjnIkrpaVp7MKzwqtfrIO2CUPe103x84nb7j71L53RkO3uZceP
         Wq/9SKbxdHk0EOJNTRfkjBK1/NGeAP849NNlK/ySImbsAL6TXZLJKPgfgKHCsyD0xn
         cC78eys5rBxN2E4HbV+m7vTmx/N6DJB0zhfd56zbv1n3J+1os8YfrSzrCOnnYj8XZ+
         8kAixmY4B7oIokfzG6QgwR7sV1/IGcit5kFaevbE0GZ45i24ktF2zDo59Spgik3sZX
         ba7X0L8qdWaixlZ0XcqXhTFCadCXyhs/Ia8MayqAQhovkQLdjAmh7U30V6SJNU/NXm
         93oIfRcov/8yA==
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 17 May 2022 10:41:27 -0300
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
Subject: Re: [PATCH] arm: dts: imx6ulz-bsh-smm-m2: Support proper board power
 off
In-Reply-To: <20220517133540.2456987-1-michael@amarulasolutions.com>
References: <20220517133540.2456987-1-michael@amarulasolutions.com>
Message-ID: <bd342e6be1723daa3787c7088c3510d0@denx.de>
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

Hi Michael,

On 17/05/2022 10:35, Michael Trimarchi wrote:
> From: Simon Holesch <simon.holesch@bshg.com>
> 
> Supports initiating poweroff on SNVS_PMIC_ON_REQ signal.
> 
> Signed-off-by: Simon Holesch <simon.holesch@bshg.com>

You missed your own Signed-off-by tag here.
