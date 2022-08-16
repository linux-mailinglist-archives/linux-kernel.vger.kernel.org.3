Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D199F5952C4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 08:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbiHPGmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 02:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbiHPGmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 02:42:37 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F1214EBBA
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 18:31:23 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id u3so12864288lfk.8
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 18:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=7TyoM62NCZIF/E5AFBSvac1IoKHCKnc+Y34dVW1eFns=;
        b=52twqYpswvNn+4ufPoVuXYwtbANQzS3ciJHHysFqnHecqsLdTFoUN61U2QnWgSOr/i
         TQXgO1Kgv9T1Y5tejanZLTzhnIOUEsj5CMpDvBvcmdPa8Ln6VeZXc+jRILGAocJ6E8RW
         7y08HcEa1rce+7Swcc0KuD+qTjLsrwqbtFz126x5RHIN/0PddL+W1xRRoH7AH1YRe/Rp
         CXDOW5VF9sZxW9yiFOQMjwzFnMIDKsAw/XyYbFvxPA2rDgUt1AgEnHLi0I5dZKVeURfk
         ZP4BOyrrJzorHKeWyI48/PMOKhIAdiBwuCr9OkfvKfwMUdHgOk+7ncSIvuE5Zpd605x2
         Q6eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=7TyoM62NCZIF/E5AFBSvac1IoKHCKnc+Y34dVW1eFns=;
        b=2fqKHj8O+uGTgUXADLBTkvxowXA1gMILYhnV03feVVsHgkOaBLW3NlSgAQr6113ksO
         TNmG57h3L9IPMg0JxNEK0FD5Lby25Ja5UM7VwELjLtYiCSuNu8l6LAfr3ctNI8WNYZFk
         ZArQstyKcxX0Nat0AR7n3DCotKgeWKn2xlRyEOsB59kk3HklgcMffRETfLkYR3aL/eez
         rljeOC+coH2VqTDolAgZxOgfoFd+R4zc3fejc9TkGmGD2z5b1ExFiKEM2/R0HSnqgnXo
         Du29CaEy96oW+5DPmyQgMCO6hxxDmKhlQQxJEVNijRr1jcieMbWJVQ4JNO4LJ9tDkQOa
         8Ifw==
X-Gm-Message-State: ACgBeo3m5a6mE6vDWKzZCULi3axRMYjecYA1rnDiXp6Ymws6VadXIGT3
        up+LLAXyR+LGdnPKybEAzZHR7muSRydycgl/ebVol131JbkRgA==
X-Google-Smtp-Source: AA6agR49I5XQ54GRFcSaPPrWeKWJQ1VX4qlPtuaRTyVtiXCjCJXwKQDjJPBmvzfPhHNye0mxtkh2JKlWpGWhbwfbcxg=
X-Received: by 2002:ac2:563b:0:b0:492:8f3a:44fc with SMTP id
 b27-20020ac2563b000000b004928f3a44fcmr1878799lff.645.1660613482321; Mon, 15
 Aug 2022 18:31:22 -0700 (PDT)
MIME-Version: 1.0
References: <CANXvt5osmx+iFdVXYQhGcdBiz5VsA60jzdKXg42c_zSDuxoHxg@mail.gmail.com>
 <20220815183920.GA1960006@bhelgaas>
In-Reply-To: <20220815183920.GA1960006@bhelgaas>
From:   Shunsuke Mie <mie@igel.co.jp>
Date:   Tue, 16 Aug 2022 10:31:11 +0900
Message-ID: <CANXvt5oOZfPZp6gMjS7AL=NPjUuKTXW6Co-o9w+-X3hyM0k+aQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: endpoint: fix Kconfig indent style
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Jon Mason <jdmason@kudzu.us>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Frank Li <Frank.Li@nxp.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ren Zhijie <renzhijie2@huawei.com>, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjom,

2022=E5=B9=B48=E6=9C=8816=E6=97=A5(=E7=81=AB) 3:39 Bjorn Helgaas <helgaas@k=
ernel.org>:
>
> On Mon, Aug 15, 2022 at 12:00:23PM +0900, Shunsuke Mie wrote:
> > I have a question, not related to the patch. Could you please tell me
> > why the ntb related patches are managed outside the pci branch,
> > Helgaas's branch? It confused me a little to find the ntb branch.
>
> My understanding is that the recent drivers/pci/endpoint/functions/*ntb.c
> patches were merged by Jon because they had dependencies on other
> patches in his tree.
That makes sense.

> In the future, I think most NTB-related patches in drivers/pci/ will
> be merged via my PCI tree.
>
> Bjorn

Thanks,
Shunsuke
