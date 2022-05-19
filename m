Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6434852C86D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 02:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbiESAMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 20:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbiESAL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 20:11:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11436D4ED;
        Wed, 18 May 2022 17:11:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E33261798;
        Thu, 19 May 2022 00:11:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A64A2C385AA;
        Thu, 19 May 2022 00:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652919114;
        bh=EuxotF//G6gIWAWskebnr6UaVwZZMBAeIYLFksWQWIA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=khkRq0+7/l5NyZDs08bQAZiksPYxhfB9UsiAPmiZLHX6hu5+d+g6hF6j2KjCqTj79
         L4Gi7yYSR6xHW0Q0KVZAd9kwHQDCin5WmOJ+6gjbkxzezSEpU6uzHA8S37nbZtNaXp
         22p/lKCWMuIylLUWc4rjovZsv6swYmaLp9hq+EqI9fhs6hFl8Ca1zqQxEIb9pBc1ux
         Tu37Vz7sqzy764PipmmdJYs/BF3cuxgOoNRTPA4p/67HB2TgMINBGbjXQC/haxBmFv
         ogjv5Iks9WgGlNx8YfvgxjbwHzmXE5FDoxd1Rwt8h8Rmh+QMQy7MwPuc1/jX+SPL0X
         DsMa1nJGb0OfQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220501103520.111561-6-krzysztof.kozlowski@linaro.org>
References: <20220501103520.111561-1-krzysztof.kozlowski@linaro.org> <20220501103520.111561-6-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 6/8] rpmsg: qcom: correct kerneldoc
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org
Date:   Wed, 18 May 2022 17:11:52 -0700
User-Agent: alot/0.10
Message-Id: <20220519001154.A64A2C385AA@smtp.kernel.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Krzysztof Kozlowski (2022-05-01 03:35:18)
> Correct kerneldoc warnings like:
>=20
>   drivers/rpmsg/qcom_glink_ssr.c:45:
>     warning: expecting prototype for G(). Prototype was for GLINK_SSR_DO_=
CLEANUP() instead
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

>  drivers/rpmsg/qcom_glink_ssr.c | 2 +-
>  drivers/rpmsg/qcom_smd.c       | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/rpmsg/qcom_glink_ssr.c b/drivers/rpmsg/qcom_glink_ss=
r.c
> index dea929c6045d..776d64446879 100644
> --- a/drivers/rpmsg/qcom_glink_ssr.c
> +++ b/drivers/rpmsg/qcom_glink_ssr.c
> @@ -39,7 +39,7 @@ struct cleanup_done_msg {
>         __le32 seq_num;
>  };
> =20
> -/**
> +/*
>   * G-Link SSR protocol commands
>   */
>  #define GLINK_SSR_DO_CLEANUP   0
> diff --git a/drivers/rpmsg/qcom_smd.c b/drivers/rpmsg/qcom_smd.c
> index 7c8c29f6c91d..e7e49d972d36 100644
> --- a/drivers/rpmsg/qcom_smd.c
> +++ b/drivers/rpmsg/qcom_smd.c
> @@ -729,7 +729,7 @@ static int qcom_smd_write_fifo(struct qcom_smd_channe=
l *channel,
>  }
> =20
>  /**
> - * qcom_smd_send - write data to smd channel
> + * __qcom_smd_send - write data to smd channel
>   * @channel:   channel handle
>   * @data:      buffer of data to write
>   * @len:       number of bytes to write

Not part of this patch but it says "flag to indicate if write has ca
wait" and I wonder what "ca" means.
