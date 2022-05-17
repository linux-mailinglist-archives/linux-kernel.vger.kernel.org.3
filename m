Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0655E52A3D7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 15:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347264AbiEQNuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 09:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347224AbiEQNuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 09:50:39 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 483A44D251;
        Tue, 17 May 2022 06:50:36 -0700 (PDT)
Received: from mail.denx.de (unknown [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: festevam@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 3213B8421D;
        Tue, 17 May 2022 15:50:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1652795434;
        bh=5IXUV2Kx1xnVHXkrKKZKLgyVgw2cRYtB2GljMt0oZ/s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XKduPSBR2aFo+VuIYzkbIjJErbNOwrIHzNFsDg/5lQpMd2DWtoH84qMCrL65r1YSh
         nJkk6Zc7HSjinfnCfHaHYnFtzWwtmdNECIPfNRPIepL9/g3gYc0GU2qWoNC/GylZ2U
         EXHdoNJfmUwAqk1q5vkaVlQ9t4LjfDYRe0Es5TxVrE3/ehQ0sSIhmMLUEKeYo7HpVh
         qkjews15k2cliVCQO1gzhBvRdn2fl9BnFT9lvRYwBnm7duETnzT7z/SGl7kWU4bkvm
         Mzsdih6dg4gdbahCU3YaeDp+UD/MLquMXBfSq+YbLdCayPjXPWfLBZLI7kGBuQ6rIV
         xdIkOMdeF1vig==
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 17 May 2022 10:50:34 -0300
From:   Fabio Estevam <festevam@denx.de>
To:     Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
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
In-Reply-To: <CAOf5uw=QxFM=CCFLZ=fZCfn9BBz1aFpkPQuED1uHxHRABwMHMQ@mail.gmail.com>
References: <20220517133540.2456987-1-michael@amarulasolutions.com>
 <bd342e6be1723daa3787c7088c3510d0@denx.de>
 <CAOf5uw=QxFM=CCFLZ=fZCfn9BBz1aFpkPQuED1uHxHRABwMHMQ@mail.gmail.com>
Message-ID: <7e434e2426ab61476e5f58db764cbd9f@denx.de>
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

On 17/05/2022 10:44, Michael Nazzareno Trimarchi wrote:

>> You missed your own Signed-off-by tag here.
> 
> It's fine, I can add Tested-by: Michael Trimarchi 
> <michael@amarulasolutions.com>

If you are transmitting someone else's patch, then you need to add
your own Signed-off-by to it.

This is explained in Documentation/process/submitting-patches.rst:

"Any further SoBs (Signed-off-by:'s) following the author's SoB are from
people handling and transporting the patch, but were not involved in its
development. SoB chains should reflect the **real** route a patch took
as it was propagated to the maintainers and ultimately to Linus, with
the first SoB entry signalling primary authorship of a single author."
