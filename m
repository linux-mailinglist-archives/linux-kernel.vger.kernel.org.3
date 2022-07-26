Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBD0558148C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 15:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239126AbiGZNyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 09:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbiGZNyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 09:54:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0274B24F1C;
        Tue, 26 Jul 2022 06:54:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 92B73615A2;
        Tue, 26 Jul 2022 13:54:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC453C433D6;
        Tue, 26 Jul 2022 13:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658843641;
        bh=NsZa52p2ynEaIvhICGHrQMtOVXRG9E3jN1QnbN5WGeM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bGjlQ3qmvOSu3K8NQVFD8i6oRXVjgTD8ZBNhM/OAvqwz/jyzJ2RvUK7vl0BtnV38z
         hFA/aiJQtfUk+6wSAJrJZp0bJJj3tZxVI1KDT49xwYO9sPylo7C3oJ0GIukz/DPDZz
         LACyFvjQFPqB6MlVQuchaytvpk83fciEOVGUrJCaeWr878vxr5qKg6Jp/YRLkV+n1f
         cJOMM743SRV1bHcxoIu2DLrlievl2vSluyPmMxWDmbi1KU5HqcJclE+t4wm5fNKmj8
         SfvgPzWLI8rz54MN4vDL9EwJV1Csx9xb+5DMElRcLa+aeGmqD3RcJ+elOSOB8BDyAj
         q+su/JQrz9VAQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oGL0n-0001xy-Fr; Tue, 26 Jul 2022 15:54:13 +0200
Date:   Tue, 26 Jul 2022 15:54:13 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Parikshit Pareek <quic_ppareek@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: introduce sa8540p-ride dts
Message-ID: <Yt/yBbIvav1+TE5s@hovoldconsulting.com>
References: <20220722143711.17563-1-quic_ppareek@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220722143711.17563-1-quic_ppareek@quicinc.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22, 2022 at 08:07:11PM +0530, Parikshit Pareek wrote:
> Create new dts file specific for Qdrive board based on sa8540p chipset.
> Introduce common dtsi file sa8295p-adp.dtsi, to be included for adp and
> Qdrive board.
> 
> Signed-off-by: Parikshit Pareek <quic_ppareek@quicinc.com>
> ---
> 
> Changes since v1:
> - Add , after year 2022, in the license header
> - Rename the dtsi which is suitable for common to many ADP boards
> - Correct the allignment in the Makefile
> - Split the patch in introducing common dtsi file, and adding new board
>   file

This changelog would probably make more sense in a cover letter. Also
your patches are not threaded (e.g. don't show up as a series in out
mail clients or on lore).

Please consider using git-format-patch (which has a --cover-letter
switch) for generating the series and git-send-email for sending, which
should help with both issues.

Johan
