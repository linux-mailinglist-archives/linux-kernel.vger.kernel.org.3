Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0903C4B62BE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 06:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234090AbiBOFbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 00:31:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234103AbiBOFan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 00:30:43 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E000128648
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 21:30:20 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JyV6H584Hz4y4k;
        Tue, 15 Feb 2022 16:30:15 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michal Suchanek <msuchanek@suse.de>, linuxppc-dev@lists.ozlabs.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        YueHaibing <yuehaibing@huawei.com>,
        "Christopher M. Riedl" <cmr@informatik.wtf>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Gustavo L. F. Walbon" <gwalbon@linux.ibm.com>,
        linux-kernel@vger.kernel.org,
        Anthony Steinhauser <asteinhauser@google.com>,
        Paul Mackerras <paulus@samba.org>,
        Diana Craciun <diana.craciun@nxp.com>
In-Reply-To: <20191127220959.6208-1-msuchanek@suse.de>
References: <20191127220959.6208-1-msuchanek@suse.de>
Subject: Re: [PATCH] powerpc: add link stack flush mitigation status in debugfs.
Message-Id: <164490278798.270256.16110004295651186693.b4-ty@ellerman.id.au>
Date:   Tue, 15 Feb 2022 16:26:27 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Nov 2019 23:09:59 +0100, Michal Suchanek wrote:
> The link stack flush status is not visible in debugfs. It can be enabled
> even when count cache flush is disabled. Add separate file for its
> status.
> 
> 

Applied to powerpc/next.

[1/1] powerpc: add link stack flush mitigation status in debugfs.
      https://git.kernel.org/powerpc/c/b2a6f6043577e09d51a4b5577fff9fc9f5b14b1c

cheers
