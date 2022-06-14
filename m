Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9735A54AC0C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 10:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354207AbiFNIlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 04:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352827AbiFNIkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 04:40:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0563F427D8;
        Tue, 14 Jun 2022 01:40:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B48E2B817DB;
        Tue, 14 Jun 2022 08:40:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FC2FC3411B;
        Tue, 14 Jun 2022 08:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655196011;
        bh=md/hhacy6Xjty9NLHaPlGwpLO6qKQ3qcDjhq4v/Auk0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=iq7uZHjZcOJSfxTsPh+UwmlAkkNxiZt0WHrZKXauUcxQqVevfx8eBY/gYW1M8qtof
         lb2uTGspgRsZ/3BqExC7h3Kq0xOhtWD/U+zvNO3vnSLZMg4DvzWownaUZALTZ1ELFs
         atbe/al9tkdao6weGW9jvLjQAzSQntezaaQPu9VYYo5lczd9gxhcocCbZBQVYmXA55
         9iOMVmBe0lcfF1m/NCeYKvRR7m0SVUcn4U/A9hEIHm80fETm2BK0HkMVsgD70Nokxk
         GeqerXzinCqYOruUxuHi2nYBa4eekLx2hkC++i6FsUqTXoy5usazeZI6uMQWpXX5jL
         ntRa4PDbJowlw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220429220904.137297-2-caleb.connolly@linaro.org>
References: <20220429220904.137297-1-caleb.connolly@linaro.org> <20220429220904.137297-2-caleb.connolly@linaro.org>
Subject: Re: [PATCH v14 01/10] spmi: add a helper to look up an SPMI device from a device node
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Jami Kettunen <jami.kettunen@somainline.org>,
        Sumit Semwal <sumit.semwal@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, caleb.connolly@linaro.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 14 Jun 2022 01:40:09 -0700
User-Agent: alot/0.10
Message-Id: <20220614084011.3FC2FC3411B@smtp.kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Caleb Connolly (2022-04-29 15:08:56)
> The helper function spmi_device_from_of() takes a device node and
> returns the SPMI device associated with it.
> This is like of_find_device_by_node but for SPMI devices.
>=20
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
