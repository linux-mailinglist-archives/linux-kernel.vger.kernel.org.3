Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E03755CC1F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236548AbiF0NzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 09:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236382AbiF0NzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 09:55:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70186AE54
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 06:55:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 38017B81707
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 13:55:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B9B5C3411D;
        Mon, 27 Jun 2022 13:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656338101;
        bh=iEW3TqgviFNZrHcd7FlnesENKzNN0DE/7TtctP2BKUI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ANeSzJrIftLsi/ebzGYxDxMi8Lh6QJTnHlAKmqRPpOcWJGHDCTCEnq1LgXJb9PBXP
         xb4sJKgYXOXKDF+HHOwDsdRaJOZUFa3/U93Dx5dwQ3+0lWKv3ghioy+cPxAcJITs+l
         MZIt4C7TqzHXLxwA1Zr3qgaV1nm3mLFS8doE+t98=
Date:   Mon, 27 Jun 2022 15:54:58 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, vincent.guittot@linaro.org,
        f.fainelli@gmail.com
Subject: Re: [PATCH 5/5] firmware: arm_scmi: Add SCMI System Power Control
 driver
Message-ID: <Yrm2sn70xJQEe4AH@kroah.com>
References: <20220623124742.2492164-1-cristian.marussi@arm.com>
 <20220623124742.2492164-6-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220623124742.2492164-6-cristian.marussi@arm.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 01:47:42PM +0100, Cristian Marussi wrote:
> Add an SCMI System Power control driver to handle platform's requests
> carried by SYSTEM_POWER_STATE_NOTIFIER notifications: such platform
> requested system-wide power state transitions are handled accordingly,
> gracefully or forcefully, depending on the notifications' message flags.
> 
> Graceful requests are relayed to userspace using the same Kernel API used
> to handle ACPI Shutdown bus events.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
