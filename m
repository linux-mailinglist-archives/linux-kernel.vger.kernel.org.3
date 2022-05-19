Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C34852DFD2
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 00:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245345AbiESWM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 18:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237755AbiESWMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 18:12:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56DB95AEDD;
        Thu, 19 May 2022 15:12:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 100F1B828BC;
        Thu, 19 May 2022 22:12:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1582C385AA;
        Thu, 19 May 2022 22:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652998372;
        bh=snNu1xBFP4oMNWqFEEMVmRKlCMOfeoYhUoVplr/SIEc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=caRx+8OFLIHF0jdcYN3Lqpqx1cAhpN4HUCWD/jP00LmQxMih44bCoCWw0fCmDYIA2
         U3pgranw7DqR3JRnXOjVvgXpd9TvE6rXBS4H1NTT/69yAAoJ7oxvTIMck2jF8r+QS8
         s+h34kAXCwRYTyj5hGxeWxTc36zBygXkkQqbQUAcMnQrUlLBv/0mC0UCfWqnnlSfuM
         wOceKCHJtejawdHnKViOxmCAja8hfrFeoVfTYmAn2t3Mk5Y26HFEI5WRnUaQTV/IR+
         Q88aMjd6poIl2S2zVj4/o4hJUuPGyjwPWg8ZNmB8mgAIfVVsumoc2Q47x5Q7nPe4rL
         SZRFQ1NbCBpdw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220519073410.7358-1-krzysztof.kozlowski@linaro.org>
References: <20220519073410.7358-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2] firmware: qcom_scm-legacy: correct kerneldoc
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 19 May 2022 15:12:50 -0700
User-Agent: alot/0.10
Message-Id: <20220519221252.C1582C385AA@smtp.kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Krzysztof Kozlowski (2022-05-19 00:34:10)
> Correct kerneldoc warnings like:
>=20
>   drivers/firmware/qcom_scm-legacy.c:133:
>     warning: Function parameter or member 'dev' not described in 'scm_leg=
acy_call'
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>=20
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
