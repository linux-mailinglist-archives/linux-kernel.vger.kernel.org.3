Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 111F550ED67
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 02:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239890AbiDZAQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 20:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239842AbiDZAQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 20:16:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49671229C4;
        Mon, 25 Apr 2022 17:13:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D9086166E;
        Tue, 26 Apr 2022 00:13:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2EC5C385A7;
        Tue, 26 Apr 2022 00:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650932028;
        bh=G4bW56lXooVwWYRzpTrcQvBZ2IrSN9hRhrv+b5mmqO4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=FwF0xQgpGfNbRm0oZMjoC7fIOjuKRUVBncAsfnG0jdWvkZUGVmzlpfADS1B1EfNsn
         sigxw8aXG6ZlUOfkrMqT1KnzT8NoF6R6Jg4Sj3gTBKOHTrOJ7CDSX8r5zPw4HgjpUF
         YvfI8TH+uvNpr8EVDuZyWhTInKOp3z9JiEQuS3dXUBfnI02IcY+4QrIvTf0MUcc5Mc
         oOiCztXWyXYIb6xItfc+gNw5fsI/vlCfJa3avfu/LDzQbFCHKex1OT1hGPT45xRjNH
         o4JBwETp06Q9XNX0zl96/QIHvLkUNedwkg7n89XlXlXbIx5Fjeac/vVPD0Mr+7GC19
         4CZep/Jt3XWVw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220409132251.31725-13-chun-jie.chen@mediatek.com>
References: <20220409132251.31725-1-chun-jie.chen@mediatek.com> <20220409132251.31725-13-chun-jie.chen@mediatek.com>
Subject: Re: [PATCH v5 12/15] clk: mediatek: Add MT8186 vencsys clock support
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
Date:   Mon, 25 Apr 2022 17:13:46 -0700
User-Agent: alot/0.10
Message-Id: <20220426001348.A2EC5C385A7@smtp.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chun-Jie Chen (2022-04-09 06:22:48)
> Add MT8186 vencsys clock controller which provide clock gate
> control for video encoder.
>=20
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Reviewed-by: Miles Chen <miles.chen@mediatek.com>
> ---

Applied to clk-next
