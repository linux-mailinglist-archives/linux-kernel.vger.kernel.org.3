Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5CA52A4EA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 16:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348987AbiEQOdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 10:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238736AbiEQOdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 10:33:17 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F25926136
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 07:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=DOvkIYxnhh8zIthAtg4aATCVKR+GZV6U2k2WThVQMyQ=; b=Qhz1miOtR0kpZViQJiqORGxYsS
        EOLRC934ob+9SOwHx1Ttwr7wVVusX2M0SmuB4wobKZgZTqmkQqkPwkpHp376mbKXHnazO7OymprEt
        5xi5dUmcXubzk0kQjhdJLs2LGO+mMngCzAkRC9iczkGdpU4Dz6bH1BYPdCF1pmXk7mciSZ9bmf1zZ
        dZGHTHEe0O8BOpAoMsrqP65uRXGLlg0zYe0wyL+D73JFws1JhDlG+FUX1ukZhdpowX4/cNyHDTnrD
        cLG5rUYmZ6PF7PhXz5aUtw+SECtMSIwpPaX2lBnKc6qmG9M42DH+l+VD3by3MmTfRMjqKipBzriUv
        Qo4a6iEw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:60746)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1nqyG9-0000PR-CT; Tue, 17 May 2022 15:33:13 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1nqyG9-0004VU-8i; Tue, 17 May 2022 15:33:13 +0100
Date:   Tue, 17 May 2022 15:33:13 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Juerg Haefliger <juerg.haefliger@canonical.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@canonical.com>
Subject: Re: [PATCH 1/3] ARM: Kconfig: Fix indentation and add comments
Message-ID: <YoOyKb/0Mj849mt3@shell.armlinux.org.uk>
References: <20220517141424.331759-1-juergh@canonical.com>
 <20220517141424.331759-2-juergh@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517141424.331759-2-juergh@canonical.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, May 17, 2022 at 04:14:22PM +0200, Juerg Haefliger wrote:
> The convention for indentation seems to be a single tab. Help text is
> further indented by an additional two whitespaces. Fix the lines that
> violate these rules.
> 
> While add it, add trailing comments to endif and endmenu statements for
> better readability.

I have never been a fan of that practice, but I understand that some
people really like it. At the end of the day, it's subjective, so
let's leave it as-is for the time being.

The other changes are worth having though. Please send a patch making
just those changes.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
