Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23FD14F1302
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 12:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357319AbiDDKUw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 4 Apr 2022 06:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357144AbiDDKUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 06:20:44 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88460642B
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 03:18:49 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nbJnM-0002Ek-2i; Mon, 04 Apr 2022 12:18:48 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nbJnM-0010Wg-OK; Mon, 04 Apr 2022 12:18:47 +0200
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nbJnK-0006lZ-N5; Mon, 04 Apr 2022 12:18:46 +0200
Message-ID: <b6ba2600f4e9e8108b1865f863d489a8c49d17ec.camel@pengutronix.de>
Subject: Re: [PATCH v2] reset: ACPI reset support
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        linux-kernel@vger.kernel.org, thierry.reding@gmail.com
Date:   Mon, 04 Apr 2022 12:18:46 +0200
In-Reply-To: <20220307135626.16673-1-kyarlagadda@nvidia.com>
References: <20220307135626.16673-1-kyarlagadda@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mo, 2022-03-07 at 19:26 +0530, Krishna Yarlagadda wrote:
> Some of the IO devices like I2C or SPI require reset at runtime to
> recover from an error condition without changing the power state of
> the system. Added check for ACPI handle and a call to method '__RST'
> if supported. Devices using device tree method are unaffected by
> this.
> 
> Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> ---
> v2:
> - add error checks.

Thank you, applied to reset/next.

regards
Philipp
