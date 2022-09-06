Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2EB05AE894
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 14:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233666AbiIFMkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 08:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232538AbiIFMkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 08:40:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F911205FF;
        Tue,  6 Sep 2022 05:40:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 32989B818B2;
        Tue,  6 Sep 2022 12:40:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A67C7C433D6;
        Tue,  6 Sep 2022 12:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662468028;
        bh=64MnIBlf3nXfbgX7wKE4SP5skV8w3Oj9k/TpTG/Suso=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bty7AqftWEGxpLqI8jZn8i6vKSSczbuL0N8RlWUOTMiY1mFcTfLT9cv9mn1hKzhyH
         Q4piwCfxR4u66lfwxDZZV3kC5qinLKbZtrtKL9NJkoShAFM+D3Mh4pbH0Hxr2eoXT5
         Cx6D5cpknoSGp2uXjfsiQiu4Z6/VuY+yTXNIUTdIF0c1mBbHzbadNZ2zjVcDiOY08k
         YXTaI7U+BIxkLcdBmT3BknTzqkDxO1sQ7g/quOu9bPABtUq8igaL6YlzrIsf7vzpCQ
         yYbgUg0zXIJG6SRqQ1X15/5nhaP4idsH5a6BELZbZJ71mrBC2bNyavLYYCTPehCp4N
         eDF/OJOuecqnQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 771A2404A1; Tue,  6 Sep 2022 09:40:26 -0300 (-03)
Date:   Tue, 6 Sep 2022 09:40:26 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Shang XiaoJing <shangxiaojing@huawei.com>, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] perf c2c: Prevent potential memory leak in
 c2c_he_zalloc
Message-ID: <Yxc/ug4Xtk0BjXMX@kernel.org>
References: <20220906032906.21395-1-shangxiaojing@huawei.com>
 <20220906032906.21395-4-shangxiaojing@huawei.com>
 <YxbNLphbuGjCezww@leoy-huanghe.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxbNLphbuGjCezww@leoy-huanghe.lan>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Sep 06, 2022 at 12:31:42PM +0800, Leo Yan escreveu:
> On Tue, Sep 06, 2022 at 11:29:06AM +0800, Shang XiaoJing wrote:
> > Free allocated resources when zalloc is failed for members in c2c_he, to
> > prevent potential memory leak in c2c_he_zalloc.
> > 
> > Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
> > Acked-by: Jiri Olsa <jolsa@kernel.org>
> 
> Reviewed-by: Leo Yan <leo.yan@linaro.org>

Thanks, applied to perf/urgent.

- Arnaldo

