Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFE2A4BC23C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 22:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239978AbiBRViA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 16:38:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235586AbiBRVh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 16:37:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612DA154733;
        Fri, 18 Feb 2022 13:37:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1EDC5B826F7;
        Fri, 18 Feb 2022 21:37:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 146EDC340E9;
        Fri, 18 Feb 2022 21:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645220259;
        bh=SG75R8KlcROnDx1nkIWdtrWdYWk4Ym8gjKexAWDRwDU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gR3Vheu0Hi+6x9vDjsoHxaWQ3DJeLAN6xwFG61+B6cSo1Sg3Dl843TYYIu3Uhq46Z
         Nv4+sY4iUXYduSq2FWbZxVgGfLdQOoFxvwbf3z1nTIls0MwI+V6siWvTDnfta240R9
         voZ4x4uE0bbLl2oIY9Lt8e0cvzzEifuciEorSUcifCrAeYOzVcIqzAp5hv0IlNHXuB
         DKbhRdlEXbHTLN/TgyDhM+mrpsDVW/45vKtq2nBqBcfY73pXYHVNosYM/DWJZ7gOru
         wlez0o9NQ29cjMBsbn1O07tW3jarvOEJTUKfW3QSjocZMmbN0gZDJYc4phcjz29fXr
         kuEDJme1iHnSA==
Date:   Fri, 18 Feb 2022 15:45:24 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Robert Moore <robert.moore@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] ACPICA: iASL: Replace zero-length array with
 flexible-array member
Message-ID: <20220218214524.GA971461@embeddedor>
References: <20220216203240.GA918517@embeddedor>
 <202202161236.FBD5D268@keescook>
 <CAJZ5v0j0+oAG3s_ZrhmG+1WaTTc-hogiKv9ZuKDiCkH8JtZ0YA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0j0+oAG3s_ZrhmG+1WaTTc-hogiKv9ZuKDiCkH8JtZ0YA@mail.gmail.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 08:47:15PM +0100, Rafael J. Wysocki wrote:
> On Wed, Feb 16, 2022 at 9:36 PM Kees Cook <keescook@chromium.org> wrote:
> 
> I've created an upstream ACPICA pull request for this change, thanks!

Great.

Thanks, Rafael.
--
Gustavo
