Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD68F5A2198
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 09:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbiHZHSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 03:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbiHZHSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 03:18:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39D3C277C;
        Fri, 26 Aug 2022 00:18:00 -0700 (PDT)
Date:   Fri, 26 Aug 2022 09:17:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661498279;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=roUA/JoTmrdvcLvJGyzDfdQUqJ5eOvFRxYS2vR+Gu/8=;
        b=pmEdvlIbNiaVaLsRDwhIaau1Ol9m983jvlB1rLXvgAImJNnihYIHfPUSYZuuv0geCb5N7Z
        zA86TkY6QzfgKZcn/29EvE6OBnweCOeZgmKHv0jgXPOVKwitQAER3mJ5GMcXor8NU2u9V2
        aH9wgbY4CyI3/ad4V2aEpPq02jF4kJFPVfgR1XKrx5yeb6UhB0a7xcPKCAA6lvcRi9Rjhz
        B15ARorWTcK7COPgC4L1OmlIzrdfiJQc/1zfQPTaIjrEFtrExALjBUYPgDELmh9S02cp/y
        67ceFN+5LosBIN/Dv0yRc+S83vy6WRZcIKomzTjRdwO2oXBCusXTlEA1Id5Pcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661498279;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=roUA/JoTmrdvcLvJGyzDfdQUqJ5eOvFRxYS2vR+Gu/8=;
        b=6L0bjDV5H38ZM1zK9ozWtZjNTsiLzljgdWFH/Ie2s0XXv7LxMHAWf+DiEwd+8EDqFJj0HS
        khUCs36LCbUAfPDQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Bogdanov <d.bogdanov@yadro.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
Subject: Re: [PATCH v2 15/25] usb: gadget: f_tcm: Cleanup unused variable
Message-ID: <YwhzppXwheosXCaL@linutronix.de>
References: <cover.1658192351.git.Thinh.Nguyen@synopsys.com>
 <420c91967948fb8e7c758ed0857c708b3b070d72.1658192351.git.Thinh.Nguyen@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <420c91967948fb8e7c758ed0857c708b3b070d72.1658192351.git.Thinh.Nguyen@synopsys.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-07-18 18:27:39 [-0700], Thinh Nguyen wrote:
> se_cmd is not used anywhere. Remove it.

This should folded into the original commit where se_cmd has stopped
been using. I believe it was when target_execute_cmd() has been moved.

> Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>

Sebastian
