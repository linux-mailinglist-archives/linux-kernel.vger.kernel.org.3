Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 960395952B7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 08:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbiHPGla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 02:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbiHPGlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 02:41:13 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5AAEF006;
        Mon, 15 Aug 2022 18:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=NVN4uwSN5xK75F6bLKWQ82Ovaszr6e9wWheX/v4qcL4=; b=ryon4aRuQD606z3gOUxtGJRVHr
        i7YyhHop9K+PfcDcnkNh0NMJlG/BVCon0e1Kw9kWiSvLTCYVXlI6bJcWeCjnlL+pY0NhnPqaPf+ko
        tk725qT4dy7W6kvbMXOK2KiVuH4FfSM05jWYZ1OOoMBh1yMe43cVY7hNtcBKu3Da2Xp6BAfzXeyJ3
        YAkDYsMbMenpdbT5urXwBIiN2k02Sd6zlq/B9csg24FCaa3wqj0DVZ5GePZ63CBrL6z4XOAC/aBlq
        kRq3idDtBnLNFnovleTMoa/iMKewf1muOi//Aq5kpQNRPZ3Kjx8naL9N9MBy+eMJk1dyV2RhsJuTs
        s7Bfukag==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oNlLx-008cPV-JF; Tue, 16 Aug 2022 01:26:46 +0000
Message-ID: <0d836243-6a02-e031-961e-1e334dfd167d@infradead.org>
Date:   Mon, 15 Aug 2022 18:26:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: linux-next: Tree for Aug 15 (input/misc/ibm-panel.c)
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eddie James <eajames@linux.ibm.com>,
        linux-input@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Wolfram Sang <wsa@kernel.org>
References: <20220815122926.7fd3ac58@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220815122926.7fd3ac58@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/14/22 19:29, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20220812:
> 

on x86_64:

when CONFIG_I2C=m and CONFIG_I2C_SLAVE=y:

ld: drivers/input/misc/ibm-panel.o: in function `ibm_panel_remove':
ibm-panel.c:(.text+0x16): undefined reference to `i2c_slave_unregister'
ld: drivers/input/misc/ibm-panel.o: in function `ibm_panel_probe':
ibm-panel.c:(.text+0x3e3): undefined reference to `i2c_slave_register'
ld: drivers/input/misc/ibm-panel.o: in function `ibm_panel_driver_init':
ibm-panel.c:(.init.text+0x18): undefined reference to `i2c_register_driver'
ld: drivers/input/misc/ibm-panel.o: in function `ibm_panel_driver_exit':
ibm-panel.c:(.exit.text+0x11): undefined reference to `i2c_del_driver'



-- 
~Randy
