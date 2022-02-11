Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF134B2442
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 12:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235420AbiBKL0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 06:26:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbiBKL0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 06:26:35 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544F0E5D
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 03:26:34 -0800 (PST)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id DD6BF223EA;
        Fri, 11 Feb 2022 12:26:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1644578792;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Huq7XZw0qNSdfruXWN010/awSFwdD35NtLJBGtoEWoA=;
        b=R55i34bvyIRTYktp4mXcmiVuEPe3sBmrnR3W600CL3qaNRcozBQrvHa/e3WN7DAgO4uth9
        GPg15pnD1AEEdeWwNfvNEDZoVhkXdlF6I29o9mbXDy4ul1CNS8RcN4cFUunNHeI+Owni7Q
        XbHHmq2ugyEIcnEpt8QPs0Se06Bk+HA=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 11 Feb 2022 12:26:31 +0100
From:   Michael Walle <michael@walle.cc>
To:     Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
Cc:     dianders@chromium.org, tudor.ambarus@microchip.com, p.yadav@ti.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        quic_stummala@quicinc.com, quic_vbadigan@quicinc.com,
        quic_rampraka@quicinc.com, quic_pragalla@quicinc.com,
        quic_sartgarg@quicinc.com
Subject: Re: [PATCH V7] mtd: spi-nor: winbond: add support for W25Q512NW-IM
In-Reply-To: <1644578661-21821-1-git-send-email-quic_c_sbhanu@quicinc.com>
References: <1644578661-21821-1-git-send-email-quic_c_sbhanu@quicinc.com>
User-Agent: Roundcube Webmail/1.4.12
Message-ID: <469eb4c95dbae9940fa4c71431972222@walle.cc>
X-Sender: michael@walle.cc
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-02-11 12:24, schrieb Shaik Sajida Bhanu:
> Add support for winbond W25Q512NW-IM chip.
> 
> Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
> Reviewed-by: Doug Anderson <dianders@chromium.org>

Reviewed-by: Michael Walle <michael@walle.cc>
