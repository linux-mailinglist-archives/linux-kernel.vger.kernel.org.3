Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD63578688
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 17:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233791AbiGRPlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 11:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235506AbiGRPkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 11:40:52 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F4012D37;
        Mon, 18 Jul 2022 08:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1658158844;
        bh=IrkLks5eIUK+nX3FGtjfRZqe8WD356p9NQUNDR586w4=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=dQgnGlcwyhXL5Q+92g4v2MMLW095BBmQXJLlb7bT3WfeVpNCAkEvhkRGEVZmc6IIK
         f9TJ0idJVxTmX/hGEtV8Tr43WmvZT+358McRbKeqHsg7PKXLp6rTlSx5OKTx2q3PtQ
         Y2921I2+e03EvxTm/a8LPGabsfFHluSASjrjo5hk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.165.57]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mbir8-1ng2S20Joc-00dBdS; Mon, 18
 Jul 2022 17:40:44 +0200
Message-ID: <0523dc43-f79b-bc28-a588-80a688e143a0@gmx.de>
Date:   Mon, 18 Jul 2022 17:40:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] mm: Fix comment typo
Content-Language: en-US
To:     Jason Wang <wangborong@cdjrlc.com>
Cc:     linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220715044915.21077-1-wangborong@cdjrlc.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20220715044915.21077-1-wangborong@cdjrlc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FSSHr0eKFRjxOGG1NmNguZ4LKlBjRR/rVdJvdSSW7lRYJp4D33I
 0ldXskhyMGdK9/pZzj+hfLyAsmOr8TT1x0vrQMHVTtuwDR5fy1aOUmG2jSRGpYOYf953CKq
 PnNokTZ6vyX6FsbI+/asg/UfitUAbXHOE0Qo7zUdGG23QsXq4fsezkV7Rk2PGRYfpp2y9MC
 kCy56pIdio/AgCy/YhHng==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wToMVn+bVjQ=:PqlLAp423xKvnXQeAaBP6V
 vhTmZm9L9/twUKGWfB1ee8zMwnYZXzoaQELq2CuZmMMQgB42C2Y/LjT0B2Xmc1G5iPifnectZ
 oBjXQbZoBPloaTrTtn3ybuLQVzazQ7dEMUqcz8i7faebu7BkKCp1W8Wb/4wEmKnYR1bZ69fq0
 KA/8J5aYNPMtIR47Jbv97CdKBekiSADe0qhT5wXGrgcWnunyrbokYqVmABQqffSeIqwZQPgOz
 k52NZRWURxyzhwpPKer4VygCRlLCc4nHmN/ln0bNNCB9eGyj//Q+cgyIi7hJkcLgd0UP2SpjK
 s9KWESkMym337IkZFMhyY1ALeK01ljw2qESuJJnTM1ppoaYnrEmtW+YjdyvJne/z6N1irSiV7
 tvo299uzzqpwu61mn4Xe3FfZ3BZKtzAjjCltzv4BNpo/y+jofYyq1mXS4Kz4Tbltn/wW6oElI
 w1JOLiHAb0BiWlixNloA5bwrzesHak/QBPHC3cpQdPDEzpR5Ya307GFtk06oNlSiYbccmmuys
 SkSpnahxSKhKOE9R1KBg3BMtLiboDrUkUV5Oc7Os2AHmcq7/HhbP4CnaI4/J1xcxwhCSDXpKo
 isLaEh9uAbc2ZnHQUvT0AlAGTyEfqUo90ucZ3PKQ2yJDl0MUcNOUm5TsqaSublOPo4bypWTll
 6aDlBLT7rv2UnuARPJMAm6fNIQi8FYsPc8+A8BdCDIbdRJSic4lU9OLKdxP5lJ8bOwJUIzFAE
 gsimSPT+iTwSAVmaI0NwmaDnHGMss9zhsafnmIu7y/3eHKOA2OzO0uyKFBi0qnyFyCgpVTzqh
 kikKj7bSukwKkXXj6aHv+TQTO3tMmPy7Mgid5bQzlZwUzbyJ96dSR+RaKk0KQaiso4B3MGvgB
 e2LyjhOhQJChg7ELehy7ucn9GZVt3G2MZMFcrg6VVSH7mGM+pzt3DYpG1kO3z2Z2hQxKzXJhJ
 pBy4uSh4dRzH9XCTB+eYCo2eE8evkhA6vhDLkXxOJry82u5sBGPpBDsUA2SOm6sTbsIFzSGOG
 cxWbJkVHVPMojsVHMhcbagS6eeB8Y76BZA+ghLdfEi0639OEOuxLcrqd486eQjvlqhXQbBDTy
 cUr0JrX5kGBfLquiaOme8mFp7LEkLwdoYLcfz7B/6HrB+7or0u+/aW/aQ==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/15/22 06:49, Jason Wang wrote:
> The double `the' is duplicated in line 41, remove one.
>
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
> ---
>  arch/parisc/mm/fault.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

applied to parisc tree.

Thanks!
Helge

>
> diff --git a/arch/parisc/mm/fault.c b/arch/parisc/mm/fault.c
> index 9ad80d4d3389..869204e97ec9 100644
> --- a/arch/parisc/mm/fault.c
> +++ b/arch/parisc/mm/fault.c
> @@ -38,7 +38,7 @@ int show_unhandled_signals =3D 1;
>  /*
>   * parisc_acctyp(unsigned int inst) --
>   *    Given a PA-RISC memory access instruction, determine if the
> - *    the instruction would perform a memory read or memory write
> + *    instruction would perform a memory read or memory write
>   *    operation.
>   *
>   *    This function assumes that the given instruction is a memory acce=
ss

