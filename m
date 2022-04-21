Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF3F250994B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385913AbiDUHjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 03:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385866AbiDUHij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 03:38:39 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7939CDFEC
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 00:35:50 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 23C10FF803;
        Thu, 21 Apr 2022 07:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1650526548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HEoc1vhPIBbeW5Cg/z4Ftn7IujLen2JFeBGa5Tkzd3Y=;
        b=f9mdmnWbNtt2L6o0HWanTF+G/K8mMA79i2U2R5n1KSHhikjhteW9UVzQgM7THMECO2nQrf
        nQtDoSMWJdoopy0UbXJyhEhCLLCtVtO6RXV1K7shMTzt9E0w74IN8ULkLkYr+4zw/fmI2Y
        eNFDgU6qE/N0l3+/haaP1YifjTFroaxlE2ZCsTaY/aS86/eqLy0MJzptsYr2NJPu2Vh3qp
        4ByPClb5X92x2b5sTclMBXjnLmNVJtqp6fGpHe+q5MdgzKS1dSSTfJmqQDpPR8/8Lxpq8y
        xf6CIOXpVTGeqIxq6qUwZaJOsuwq9QiDLQlRM4EFequG6mN+pkdEHYlFaVxQvA==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jean-Marc Eurin <jmeurin@google.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v3 2/3] mtd: mtdoops: Create a header structure for the saved mtdoops.
Date:   Thu, 21 Apr 2022 09:35:47 +0200
Message-Id: <20220421073547.71951-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220415001321.252848-3-jmeurin@google.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'0629fcef16d703d384f76cb2c2c3a119a9149a34'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-04-15 at 00:13:20 UTC, Jean-Marc Eurin wrote:
> Create a dump header to enable the addition of fields without having
> to modify the rest of the code.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Jean-Marc Eurin <jmeurin@google.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
