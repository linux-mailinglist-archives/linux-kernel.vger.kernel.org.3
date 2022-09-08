Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 624D85B13BA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 06:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiIHEbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 00:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiIHEbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 00:31:53 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD8D816B8;
        Wed,  7 Sep 2022 21:31:51 -0700 (PDT)
Received: from nazgul.tnic (unknown [84.201.196.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D58771EC0662;
        Thu,  8 Sep 2022 06:31:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1662611506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=0nvDue4vLSHB9eljGkQK3Ucd2hQfwmu9py9vEraev3s=;
        b=kH7QR8UJR/Jv9S+ZatWpkDuGnAdOKHYhXeTVzGozo20k83qlg15fWg3pFKQTF1H6GtwI2s
        xYe0bIt84Dd4vIISvV352h9TTw0UCv0GVGAkv5JoH3h68zLptnyT5tUewIoIyjoKPuDIU+
        qtbtGkJi50Y5R1D6CoU4cv4+SD3ES4Y=
Date:   Thu, 8 Sep 2022 06:31:56 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     dan.j.williams@intel.com, x86@kernel.org, nvdimm@lists.linux.dev,
        linux-cxl@vger.kernel.org, peterz@infradead.org,
        akpm@linux-foundation.org, dave.jiang@intel.com,
        Jonathan.Cameron@huawei.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, a.manzanares@samsung.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] memregion: Add arch_flush_memregion() interface
Message-ID: <YxlwPOp9pRrH1luo@nazgul.tnic>
References: <20220829212918.4039240-1-dave@stgolabs.net>
 <YxjBSxtoav7PQVei@nazgul.tnic>
 <20220907162245.5ddexpmibjbanrho@offworld>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220907162245.5ddexpmibjbanrho@offworld>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2022 at 09:22:45AM -0700, Davidlohr Bueso wrote:
> So the context here is:
> 
> e2efb6359e62 ("ACPICA: Avoid cache flush inside virtual machines")

Please add this to your commit message so that at least we know how this
HV dependency came about.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
