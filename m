Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2AC6530D15
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 12:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233168AbiEWJdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 05:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233203AbiEWJc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 05:32:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4125649C9F;
        Mon, 23 May 2022 02:32:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B94B6100F;
        Mon, 23 May 2022 09:32:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1C8BC385AA;
        Mon, 23 May 2022 09:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653298373;
        bh=oF93QZ7WtaZauyLG88zBTuYFbJ6yJDyEbM2VtdtfBmc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ggSgr2UQyzrJD0AC6AlWvYelXwk89msKdU2VvFHSTlV8W9Y759hj42EDl138FkK9w
         EBJbw/kq8AIus+UvqjeuUHlMgujyLoAS37MwFIr4ojGnq/bVGf24k8NTZTpgokVXyN
         Dbk8wyEf28y83noSL0vo133mlPpxYD+JZmct7ETbwb4tlrbvgD4xCbO9E32TDpbJOQ
         6rvkNqBp5PW4gIwRYnxb5CaVv+kU5Y3ijceD4DZV0IRHwGlYZve0gNfaiPxc0LwAob
         5fu4ydugidl68B8epiuXeVv0uxh5NQRmxrQDttyrqAhGAh1xIOD9WHIYe0DFn4L+W5
         eNBnk2ytukjyw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nt4Qk-0001HB-UZ; Mon, 23 May 2022 11:32:50 +0200
Date:   Mon, 23 May 2022 11:32:50 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_tdas@quicinc.com,
        quic_rnayak@quicinc.com
Subject: Re: [PATCH 0/3] clk: qcom: gdsc: add support for collapse-vote
 registers
Message-ID: <YotUwhIrwlSXH6Ak@hovoldconsulting.com>
References: <20220520100948.19622-1-johan+linaro@kernel.org>
 <20220521035111.A94B7C385A9@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220521035111.A94B7C385A9@smtp.kernel.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 08:51:09PM -0700, Stephen Boyd wrote:
> Please add Qualcomm on code for their hardware :)
> 
> I did a translation from codeaurora but I don't know if Rajendra's will
> work.

These addresses need to be added to .mailmap.

> Quoting Johan Hovold (2022-05-20 03:09:45)
> > Recent Qualcomm platforms have APCS collapse-vote registers that allow
> > for sharing GDSCs with other masters (e.g. LPASS).
> 
> How is it different from the voting logic that already exists in the
> gdsc file? Now every subsystem has to vote for off in addition to voting
> for on?

No, the voting logic is unchanged (i.e. enabling by clearing a collapse
bit).

The difference is just that a separate register register is used for the
voting.

> >     
> > Add support for using such vote registers instead of the control
> > register when updating the GDSC power state.

Johan
