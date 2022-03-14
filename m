Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC69D4D838E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 13:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240902AbiCNMQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 08:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241312AbiCNMIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 08:08:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC6A4BBB1;
        Mon, 14 Mar 2022 05:04:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CB41FB80DEC;
        Mon, 14 Mar 2022 12:04:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABCB0C340EC;
        Mon, 14 Mar 2022 12:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647259494;
        bh=tV82BqDO0AsjvHNlIhCJicG5lFAeNtcRzJzz1XpeSds=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qYFlmSkdisUfwzRsUpQ1ZJH7Ei1DCePaIe3y4UVsIryWRl6HDJ4B3kqwp5Jg9JiW5
         sJpyctpVBJ1rU2W+uK7PUzg2aG15UJj1a5rYGmgb7hcZVP1rWpvObl4JrY9RSQj/nO
         oE42bLIJ4j13VitrmJ6XPbVqZcGhrlKXBrjyMAvJWHZUgpyZn7f/7O+yUSQft1veI7
         8t9n14bDMkFQVU4dNZg446VPLzZDU0+u7CcQCQsAPvZEhMm4rpbba8+bhgF8IaKXo4
         ZU6Y/pd8l3PutJ1e9YQdLxRHhP9anv5ZWokMA4b+FEs3NNNlF2UFbyFoAwWsVdTHpL
         tYoX+ZrJ6nH+g==
Date:   Mon, 14 Mar 2022 13:04:47 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Niklas =?UTF-8?B?U8O2ZGVybHVuZA==?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Dmitry Osipenko <digetx@gmail.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ming Qian <ming.qian@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Shijie Qin <shijie.qin@nxp.com>,
        Zhou Peng <eagle.zhou@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-media <linux-media@vger.kernel.org>
Subject: Re: [PATCH 49/64] media: platform: rename amphion/ to nxp/amphion/
Message-ID: <20220314130447.7f03f726@coco.lan>
In-Reply-To: <CAOMZO5CHPYR+sdSS1ay_Zr1qL0XCGCJ2kqMxK3JxDuxDtjFCtA@mail.gmail.com>
References: <cover.1647242578.git.mchehab@kernel.org>
        <bb359b4709ceb1112813965237d153cd366cae2d.1647242579.git.mchehab@kernel.org>
        <CAOMZO5CHPYR+sdSS1ay_Zr1qL0XCGCJ2kqMxK3JxDuxDtjFCtA@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, 14 Mar 2022 08:29:14 -0300
Fabio Estevam <festevam@gmail.com> escreveu:

> Hi Mauro,
> 
> On Mon, Mar 14, 2022 at 4:56 AM Mauro Carvalho Chehab
> <mchehab@kernel.org> wrote:
> >
> > As the end goal is to have platform drivers split by vendor,
> > rename amphion/ to nxp/amphion/.  
> 
> Amphion is the vendor itself, so the current naming scheme is correct.

Ok, I'll fix it on the next series.

Thanks,
Mauro
