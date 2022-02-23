Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F834C0CD1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 07:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238509AbiBWGyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 01:54:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236710AbiBWGyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 01:54:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE0A6E4DE;
        Tue, 22 Feb 2022 22:53:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7AFDC614A1;
        Wed, 23 Feb 2022 06:53:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CB85C340E7;
        Wed, 23 Feb 2022 06:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645599236;
        bh=CC5KnLvYTDWcou/flBRkpm74kh6sin3lWzN3f4vNh0Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ni0uF5R9i52mHG8G36cXjuU2W3LNpT1OdXi3tD3lffJSk3IScFS6t+UiinH02/a5D
         hTdObu6TTksvfrXTAYQiO8WdmFBNDuYVpss3+Z4x20FyxNXqXnDjbwBgzxU9EL2l+P
         brpJN0R9k9RqLe/T4VibAuTcwT4S5n8MtVuBE5fg=
Date:   Wed, 23 Feb 2022 07:53:53 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] ACPI: bus: Introduce acpi_bus_for_each_dev()
Message-ID: <YhXaAbgtF7OQ0bbs@kroah.com>
References: <11943345.O9o76ZdvQC@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11943345.O9o76ZdvQC@kreacher>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 08:51:42PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> In order to avoid exposing acpi_bus_type to modules, introduce an
> acpi_bus_for_each_dev() helper for iterating over all ACPI device
> objects and make typec_link_ports() use it instead of the raw
> bus_for_each_dev() along with acpi_bus_type.
> 
> Having done that, drop the acpi_bus_type export.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>


Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
