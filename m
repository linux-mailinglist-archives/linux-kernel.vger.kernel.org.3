Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33AB7546D5C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 21:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350152AbiFJTkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 15:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244754AbiFJTkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 15:40:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1237513CE7;
        Fri, 10 Jun 2022 12:40:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A105A62258;
        Fri, 10 Jun 2022 19:40:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03D37C34114;
        Fri, 10 Jun 2022 19:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654890034;
        bh=2abwm/QvYkPy3nk3JgP1rcQA861bNBR96FuhtkMs1iA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=HbQabMzDKYJsXqD3pF8P8V6+HPCEiF2W9fXAVBaxI828QAssTv42PCpuaxwL7VP4A
         yBaeCbPqO0JbQHC1s7cDiuH8N6KPNSQoVL4TjyFNSogYysThWe8HIm5iojModBQHFu
         8hWzKR6UnCp2LfR4M2FIg+h1aJGgA1HqM0wbdEwWoAC71yjbS51aBagY4n0ZvDhiih
         UCgLBfWgk8ou9F4M74vm9XJU+wzdbbHKLByUuGT7EhgCbP80NwzURJbciVf0ayaJQ3
         jv2zQ5UMkT0S11jxhkbwMB2ttv0QuY7SYbVDCXFqzoPzMUIInEHKCo1Mz4GTtxxmz0
         CqnYTKfLq9mZw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220531085611.122884-1-lizhengyu3@huawei.com>
References: <20220531085611.122884-1-lizhengyu3@huawei.com>
Subject: Re: [PATCH] clk: qcom: clk-rpmh: Remove redundant if statement
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        mturquette@baylibre.com, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Li Zhengyu <lizhengyu3@huawei.com>, tdas@codeaurora.org
Date:   Fri, 10 Jun 2022 12:40:32 -0700
User-Agent: alot/0.10
Message-Id: <20220610194034.03D37C34114@smtp.kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Li Zhengyu (2022-05-31 01:56:11)
> (!ret) has been checked, so remove (ret).
>=20
> Signed-off-by: Li Zhengyu <lizhengyu3@huawei.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
