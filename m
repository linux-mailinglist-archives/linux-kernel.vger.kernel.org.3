Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 143E74F4EF2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1582625AbiDEXs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 19:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389781AbiDEP0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:26:46 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28AE1EEA43;
        Tue,  5 Apr 2022 06:37:32 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id C01181F4512B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649165850;
        bh=plGTTyi7O6qDtXxCe+h/xQcs9ltHnMhWtxjOqkuVZDA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=c7CbAeTNu93R+wac0xUo8wYt5JHYwVPd64SEqW/SDwK8otS4ZmnyP2OT8Zetat059
         odFY4s7LLMRKdZx+u9DgJ+6R76/bmNzUrxwpPJMv+KYldaKtX0rVOinXvHBuewmHCd
         GPiHBfHg9bzOyApLYuAlAGJ54YI1ZvRFGvvu31CzQMNaPh7/FpmEf6WgCoWWVghk0v
         n7+V4pbW+bbDbiuVhQ74MTamguMKsNtXVYQJBaVZkV4tM1g6haDmp3nJBTJhcq+6me
         SGNpIoCdUfJATVmysl7Ianu9MVm7k8Y6RobJ0fX1h6SE+SehjaHHxv8XRMMnf90Yif
         lU13kvmJsV8CA==
Message-ID: <9999f731-1e95-ef51-4b09-c88222320696@collabora.com>
Date:   Tue, 5 Apr 2022 15:37:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] remoteproc: mtk_scp: Fix a potential double free
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <1d15923b4ffb94531435c48482fef276a11b9a67.1648981531.git.christophe.jaillet@wanadoo.fr>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <1d15923b4ffb94531435c48482fef276a11b9a67.1648981531.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 03/04/22 12:25, Christophe JAILLET ha scritto:
> 'scp->rproc' is allocated using devm_rproc_alloc(), so there is no need
> to free it explicitly in the remove function.
> 
> Fixes: c1407ac1099a ("remoteproc: mtk_scp: Use devm variant of rproc_alloc()")

Hello Cristophe,
thanks for the patch!

I agree with what you're doing here, but you forgot to add your Signed-off-by.
Please resend it with your signoff, then I will give you my R-b.
Also, please make sure to add me to the Ccs so that I can see your v2 sooner!

Thanks,
Angelo
