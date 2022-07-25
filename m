Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A26057FAC1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 10:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbiGYIBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 04:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233278AbiGYIBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 04:01:30 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BAC113E95
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 01:01:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 94E6E1F981;
        Mon, 25 Jul 2022 08:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1658736059; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H1PBuC0jiBRBBGEqLJntJLX3lel38SgGPHuPFxxLQJU=;
        b=iiTMYPIi1XY2dDcgRWqys67t7KySPokkua6IRB4IL8oPHviB1gn1yfnnlwZoro4FDmDb3b
        9AM5ZjhvwVrNFZxuleggsP5e+fhkEqxA+Bw2gszdwby2OJ6YDd6gw0EwD4KU9e6cLr4zzh
        z/y/aC9tyCDRBDTh7McDopwefp4rKVc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1658736059;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H1PBuC0jiBRBBGEqLJntJLX3lel38SgGPHuPFxxLQJU=;
        b=xtzrA6QtIIw6hLwAq4ZuOV/amKGSsW2Xepn/4LZNAZe0ADzyqZzh88UVB163k3PJBhWSRG
        srMpj+EdLWvTaoBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5B1A113A8D;
        Mon, 25 Jul 2022 08:00:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QAaQFLtN3mJyYwAAMHmgww
        (envelope-from <jdelvare@suse.de>); Mon, 25 Jul 2022 08:00:59 +0000
Date:   Mon, 25 Jul 2022 10:00:56 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     kernel test robot <lkp@intel.com>
Cc:     Sean Wang <sean.wang@mediatek.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: drivers/regulator/mt6380-regulator.c:333:34: warning:
 'mt6380_of_match' defined but not used
Message-ID: <20220725100056.0063b193@endymion.delvare>
In-Reply-To: <202207240252.ZY5hSCNB-lkp@intel.com>
References: <202207240252.ZY5hSCNB-lkp@intel.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Jul 2022 02:37:15 +0800, kernel test robot wrote:
> All warnings (new ones prefixed by >>):
> 
> >> drivers/regulator/mt6380-regulator.c:333:34: warning: 'mt6380_of_match' defined but not used [-Wunused-const-variable=]  
>      333 | static const struct of_device_id mt6380_of_match[] = {
>          |                                  ^~~~~~~~~~~~~~~
> --
> >> drivers/soc/mediatek/mtk-pmic-wrap.c:1436:34: warning: 'of_pwrap_match_tbl' defined but not used [-Wunused-const-variable=]  
>     1436 | static const struct of_device_id of_pwrap_match_tbl[] = {
>          |                                  ^~~~~~~~~~~~~~~~~~
> >> drivers/soc/mediatek/mtk-pmic-wrap.c:1370:34: warning: 'of_slave_match_tbl' defined but not used [-Wunused-const-variable=]  
>     1370 | static const struct of_device_id of_slave_match_tbl[] = {
>          |                                  ^~~~~~~~~~~~~~~~~~

Not sure what do to with this one. These warnings can be silenced with
__maybe_unused. But does it actually make sense to build these drivers
with CONFIG_OF disabled?

As I understand it, that's the condition which makes the warnings
appear, and from a quick look at the code, it seems to me that the
drivers are useless then. It might make more sense to make both drivers
depend on OF. What do you think?

-- 
Jean Delvare
SUSE L3 Support
