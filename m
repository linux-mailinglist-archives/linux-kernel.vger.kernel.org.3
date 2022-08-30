Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A987B5A5CCC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 09:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbiH3HUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 03:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbiH3HUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 03:20:41 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C7F5C9DF
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 00:20:39 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7B88B6601B73;
        Tue, 30 Aug 2022 08:20:36 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1661844036;
        bh=UzmHNdmotVM3jM3ssmk0O3EgfrsDEmWpJq3KHdX97HI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=d/+yNckIGcLBzpE2ZeBn5sYd1EPdpSk/bjsnT1Nq5qHbwat3MCutXgCGWRgboBtx0
         RfQDrwYYqbpVC6i4XDyXeGwoG4oN9gLkuUBwSYnrbbRCx1OLll/ljar3GGeLxMm6mG
         hrDWRwg5PoXxsmbVZKqmBqafEVCV3gC9MVqI5UYZp4BOKkKfe3jdBSMZJsE9MvRhll
         KedsmixzvZX1Dbf+wTkl0HmR7UfmIAFqeTbddOp5z+6xiSMVmgv+kLxLpueVVZCcfP
         0qSeMr+shkwiWltqgb+fyLtrvtF/NSqY28ko7CXz+aq1F12YouVdSWedZJQqpkYmlK
         75XLggpd96qSg==
Message-ID: <5e3668af-8841-629c-0df2-8b272167ee19@collabora.com>
Date:   Tue, 30 Aug 2022 09:20:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] soc: mediatek: mtk-svs: Explicitly include bitfield
 header
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     kernel@collabora.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20220829204439.3748648-1-nfraprado@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220829204439.3748648-1-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 29/08/22 22:44, Nícolas F. R. A. Prado ha scritto:
> Commit a92438c5a30a ("soc: mediatek: mtk-svs: Use bitfield access macros
> where possible") introduced the use of FIELD_GET and FIELD_PREP macros,
> which are defined in the bitfield header. Add an explicit include for it
> so we're sure to have the symbols defined independently of the config.
> 
> Fixes: a92438c5a30a ("soc: mediatek: mtk-svs: Use bitfield access macros where possible")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

