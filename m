Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7AE52C872
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 02:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbiESANY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 20:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiESANR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 20:13:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A09959C;
        Wed, 18 May 2022 17:13:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8D282B82257;
        Thu, 19 May 2022 00:13:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49750C385A9;
        Thu, 19 May 2022 00:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652919192;
        bh=+4aOXT/xfLFBnME6aViNBnwVtTFcrybgI1qctejV12Y=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=OgwXHnFjNRKk98mdlUMxNPUVp0tSVSIBDTfhgPQfK2vYpMPR4Vkt8yml/v/4btfV7
         gfgQSEd0EXCwHLaYELVnIWnXgOlk8q2cToF3lGVj0X7YWkXSRMz7CAQ3MVI+51qdj1
         ilPHDdnhUurfiUMGvOLBHbtmi5AjUa0z0ILglfMkeNHTgh+hU6tc7ZgXrxclrtYOo/
         bE7XoP2OROBpcP50S23hEUF6ZlKvMaN10dZniyWt//hWIImAW51NcQfdAJvdWx6Kag
         Kf0IWqoJohKhCIj7GHZiRn2L+7RGEMjLfNCroA3Y9RQu05/zjEE4kts1uNxmOCTf7k
         zrZ1m4sGYQsTQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220501103520.111561-8-krzysztof.kozlowski@linaro.org>
References: <20220501103520.111561-1-krzysztof.kozlowski@linaro.org> <20220501103520.111561-8-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 8/8] soc: qcom: correct kerneldoc
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org
Date:   Wed, 18 May 2022 17:13:10 -0700
User-Agent: alot/0.10
Message-Id: <20220519001312.49750C385A9@smtp.kernel.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Krzysztof Kozlowski (2022-05-01 03:35:20)
> Correct kerneldoc warnings like:
>=20
>   drivers/soc/qcom/mdt_loader.c:126:
>     warning: Function parameter or member 'fw_name' not described in 'qco=
m_mdt_read_metadata'
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
