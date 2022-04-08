Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAD0C4F9328
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 12:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234675AbiDHKnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 06:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbiDHKnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 06:43:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7643352E5F;
        Fri,  8 Apr 2022 03:41:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 12060B82A1E;
        Fri,  8 Apr 2022 10:41:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0D2AC385A3;
        Fri,  8 Apr 2022 10:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649414477;
        bh=4dMlwUlRjJhzVHViUt8A5Htr+QJYe+5brMn53LIeqfM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gG5BcauBKb/rGoGdIbnLuxSGqpZBCPP5UVrW3Ya1Ljf37NDig3e+U/+l7G3d+IubK
         DoRsseBoJ6krGCFKywzp0ZeFYfhzBAIRgLglxKT37vCv9xSfs5J7Bn4lcE6Hrn8KpY
         Yyhsoux9Td6LKXouPPMjtIFDmxzmFHxHNwm5YwcwKE+chm3m8G+FPACGs6RwXedc0J
         ranA4MXPT2l280XhIbr3IREoolwhIEc7jQCwOHAhbELji6ztn+LA+bzs+OYW/Bf3sT
         W1NuWsFnmKRDKGx3125yj2byk0v9B19zNG2SmdHaMQTeBGkeTQSQ34SMQDOzyM1QMV
         nXaoBYzrzZzwA==
Date:   Fri, 8 Apr 2022 18:41:11 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     robh@kernel.org, krzysztof.kozlowski@canonical.com,
        festevam@gmail.com, kernel@pengutronix.de, kernel@puri.sm,
        devicetree@vger.kernel.org, phone-devel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/5] arm64: dts: imx8mq-librem5: phone description
 updates
Message-ID: <20220408104111.GU129381@dragon>
References: <20220228131222.917137-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220228131222.917137-1-martin.kepplinger@puri.sm>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 02:12:17PM +0100, Martin Kepplinger wrote:
> Hi Shawn and all interested,
> 
> This is small updates to the Librem 5 phone hardware descriptions we've
> been using for quite some time as part of PureOS.
> 
> thanks,
>                            martin
> 
> Angus Ainslie (1):
>   arm64: dts: imx8mq-librem5: add a RO firmware partition
> 
> Guido Günther (2):
>   arm64: dts: imx8mq-librem5: higher boost regulation current
>   arm64: dts: imx8mq-librem5-r4: add the correct panel
> 
> Martin Kepplinger (2):
>   arm64: dts: imx8mq-librem5: make the volume buttons a wakeup source
>   arm64: dts: imx8mq-librem5: remove description of CHG_STATUS_B

Applied all, thanks!
