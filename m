Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11EAA518DCC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 22:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238086AbiECUJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 16:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237119AbiECUI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 16:08:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73CD72DFA;
        Tue,  3 May 2022 13:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6y73UrLkuBeZbqQWQxE1t7/fvOkdPG7FrQgvW5TbCZk=; b=uV47lbaYCI77SzKFgjANFlLdPi
        L02iSgJfX9+DktwQKv2+gW04aiFG88sPWwCOpfbWVfsKcu5mcv6/fSFU+nTtYhp4/nG6vb6sK6vO1
        VuOYw0zbi0N5oB1BXqerDMF7l1psgHzPI174q4fF7eoDfL7w+JUkH5bAerAOHbru+Yd3kpigqC8Qv
        qaW65HJ2rsoeJpsMNjSwiawKJyE5v7ztmXTNDLnq1z+n3rPjhh/MtEwPoeXxzP0/w7t/fjkR8jMOD
        yUESiFI99BpsJg2J6h3EUzozTZNBVnIfNljmTXGlRhcUON7mxblWtRdlKKftawmCl9vCGYK6Z3Mag
        IuaQzkHg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nlylv-007UQd-7t; Tue, 03 May 2022 20:05:23 +0000
Date:   Tue, 3 May 2022 13:05:23 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     linux-doc@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
        Russ Weight <russell.h.weight@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: [PATCH] firmware_loader: describe 'module' parameter of
 firmware_upload_register()
Message-ID: <YnGLA92KGlloOsLf@bombadil.infradead.org>
References: <20220502051456.30741-1-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220502051456.30741-1-bagasdotme@gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2022 at 12:14:56PM +0700, Bagas Sanjaya wrote:
> Stephen Rothwell reported kernel-doc warning:
> 
> drivers/base/firmware_loader/sysfs_upload.c:285: warning: Function parameter or member 'module' not described in 'firmware_upload_register'
> 
> Fix the warning by describing the 'module' parameter.
> 
> Fixes: 97730bbb242cde ("firmware_loader: Add firmware-upload support")
> Link: https://lore.kernel.org/linux-next/20220502083658.266d55f8@canb.auug.org.au/
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Russ Weight <russell.h.weight@intel.com>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
> Cc: Linux Next Mailing List <linux-next@vger.kernel.org>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Acked-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
