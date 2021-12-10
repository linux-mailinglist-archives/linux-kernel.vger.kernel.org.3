Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9E6A470C24
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 22:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344269AbhLJVEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 16:04:25 -0500
Received: from ms.lwn.net ([45.79.88.28]:53644 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243371AbhLJVEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 16:04:25 -0500
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 4CAA860C;
        Fri, 10 Dec 2021 21:00:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 4CAA860C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1639170049; bh=rgAgtPllHI9naYyvvCzUGL72Gp5tuP5SpnrEtd01nAQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=I6i2f+ph8RY+cpe3funTODgTXGHjB5meH1HmRerrCD3o0y3UIS28zhgJRm2n9OR02
         S6D3hqodPZf/PZr2jpj30qDs78vgo6xRzUky9CmYD+QxXq6gFKshUDB5cer3xjDTPD
         fOK12L/t3ETUCF2e9OWjKKcN6h7vNgYegs8wyLkKCm3VTAeg6j06kehICBN+cIfXE2
         8Rn3Gj3t5yJ5YOQQrV+2W8rPB5xXY51rUE8B4nsEwf/+zxJoCgpSHeqF0243x1lYHs
         oPlt73Dpg//Ib4u4Vb+36dnGvPenE3YXGVGoseCfjmQWt726k12RuQiCpKbq3kf8TS
         QqehbtXXL+Nng==
From:   Jonathan Corbet <corbet@lwn.net>
To:     yanteng si <siyanteng01@gmail.com>, Alex Shi <alexs@kernel.org>
Cc:     Tang Yizhou <tangyizhou@huawei.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] doc/zh_CN: add Chinese document coding style reminder
In-Reply-To: <CAEensMzQ1keWthwvZ1yDozQ0r3BQ2PYb5bj_5FxXeYtAY2gmwg@mail.gmail.com>
References: <20211209095604.68954-1-alexs@kernel.org>
 <CAEensMzQ1keWthwvZ1yDozQ0r3BQ2PYb5bj_5FxXeYtAY2gmwg@mail.gmail.com>
Date:   Fri, 10 Dec 2021 14:00:48 -0700
Message-ID: <87v8zwqinz.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

yanteng si <siyanteng01@gmail.com> writes:

> <alexs@kernel.org> =E4=BA=8E2021=E5=B9=B412=E6=9C=889=E6=97=A5=E5=91=A8=
=E5=9B=9B 17:56=E5=86=99=E9=81=93=EF=BC=9A
>>
>> From: Alex Shi <alexs@kernel.org>
>>
>> The coding style requirement for Chinese document is easy to be overlook=
ed.
>> Add the request as a remdiner.
>>
>> Signed-off-by: Alex Shi <alexs@kernel.org>
>> Cc: Yanteng Si <siyanteng01@gmail.com>
>> Cc: Tang Yizhou <tangyizhou@huawei.com>
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> Cc: linux-doc@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
> Reviewed-by: Yanteng Si <siyanteng@loongson.cn>

Applied, thanks.

jon
