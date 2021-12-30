Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09745481D0F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 15:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240090AbhL3O37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 09:29:59 -0500
Received: from relay06.th.seeweb.it ([5.144.164.167]:54017 "EHLO
        relay06.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240067AbhL3O35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 09:29:57 -0500
Received: from [192.168.1.101] (83.6.168.106.neoplus.adsl.tpnet.pl [83.6.168.106])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 638393F3F5;
        Thu, 30 Dec 2021 15:29:55 +0100 (CET)
Message-ID: <5543bdad-3518-fe20-d755-69ebac4ddd69@somainline.org>
Date:   Thu, 30 Dec 2021 15:29:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] clk: qcom: gcc-msm8994: Remove NoC clocks
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211230023101.1122588-1-konrad.dybcio@somainline.org>
 <CAA8EJprR_eNiRTXOLnHzztbdH_RYj-+Po99b=7c2Asxvop+jtQ@mail.gmail.com>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <CAA8EJprR_eNiRTXOLnHzztbdH_RYj-+Po99b=7c2Asxvop+jtQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> You don't have to init array entries with NULL values (if it's not for
> the documentation purposes). Uninitialized entries will get NULL value
> anyway.
>
Forgot to address this in my previous message, but I think it may be a

good indicator for the next person that decides this would be a good idea

that they should probably stay away from it.. If it's really bad, then sure, I

can remove it..


Konrad

