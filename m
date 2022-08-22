Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D2159CA61
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 22:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbiHVUwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 16:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbiHVUwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 16:52:06 -0400
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239E8520A9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 13:52:05 -0700 (PDT)
Received: from pps.filterd (m0167073.ppops.net [127.0.0.1])
        by mx0b-00364e01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MKptrp017038
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 16:52:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type : content-transfer-encoding; s=pps01;
 bh=jRzEf5ldVyXOJMmmR5MBzxUV26GRIKHAGatrWR5Rps8=;
 b=TWu/QEbE1HeBkKyLpa5scMc7WE2tJR1nLopzpBRWSxT7GSVj4FPK9eTXj6fY5M0XIjQ6
 dOrGI2nEh6jCefxuoRn7v0kdDi3+ixwePxLkCaNzmsT99mBz92O6OU9lBIiqrRy3H15i
 bXNTh5wkWwONDxjRyYgnkC6kyGEDYrKy6BcKG52cAugYes7MaaR/WwtTjWOhK4u38sRt
 tT0K3BuZCkLCdn8jo9XA3tzyX8YvsCV8sRwkdEt0GCLhd8i1WololVMAJ5nMm77qj0Rv
 HywQVWfIWFDnXA0GilDTMCKcvA2LfP67kKUtVmF1Oc+dGYXN0UG8Q5qOQAZxLfa3bCw9 cQ== 
Received: from sendprdmail22.cc.columbia.edu (sendprdmail22.cc.columbia.edu [128.59.72.24])
        by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 3j2wj7nghq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 16:52:04 -0400
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
        by sendprdmail22.cc.columbia.edu (8.14.7/8.14.4) with ESMTP id 27MKq3oJ072698
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 16:52:03 -0400
Received: by mail-ua1-f70.google.com with SMTP id u104-20020ab045f1000000b00392314bab5dso2508683uau.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 13:52:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=jRzEf5ldVyXOJMmmR5MBzxUV26GRIKHAGatrWR5Rps8=;
        b=MeOtTOtA5xNg7tU5J13dlxkgT7xSpZHobYplKtx2Wc698I/4pjkdfr1PEIojF+FJ3y
         EkR9uu6f8Nz0f4uJpjGvwRHtvQdYkky/m/MS+imgqZGJSyJMSf5FF8VvJKBIk89ZSAvA
         Nf3xpB2Xl1lzszC+BPFSwqmUefTIt9cY3QZEQMA0daOUQeW/UxHz4koqZ+LBl2JqzPLI
         VxYU2gCg+AW1ONoObczYtRguz4cDSHcGifO89mMITdbbHxDP1JSUi2FmHWiEfLG04wjI
         2huzHt+CB6P+2k+x/3BNENfyH0ItMSFYQlvaYtMAAiM1pGABV1CTiLulOHOjyA9+uizf
         EY/g==
X-Gm-Message-State: ACgBeo00IAziAFqRqcGLosoXoNMH3YR7oadrZgrefOiZ5xjFD3VnQzLZ
        fGLMMJgE0TjU3zLajuAa0Ybu0acNbcXmNSxDpiJTepxiosR3TCNP9vNAmPznpvBTnFfV+X5iNfY
        kzpRJim/+473acX0hs7PSzETRHT0O+7Cnyi3qlUe/T1HojaRz
X-Received: by 2002:a67:d284:0:b0:390:3f27:a274 with SMTP id z4-20020a67d284000000b003903f27a274mr4411362vsi.12.1661201522905;
        Mon, 22 Aug 2022 13:52:02 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5tcmijsMj/vgPupQntehD8NN8viBte3C+4jiOzfZwp48FzNQTAjr1Gcl87ULNyUQ2RcEcIAH8sPVJ7ErsYTc0=
X-Received: by 2002:a67:d284:0:b0:390:3f27:a274 with SMTP id
 z4-20020a67d284000000b003903f27a274mr4411355vsi.12.1661201522713; Mon, 22 Aug
 2022 13:52:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAEHB2488dNqBKcgWLSeq500JLC1+q6RV=ENcUPm=rN9bWf0QkQ@mail.gmail.com>
 <20220819123542.GA2461@breakpoint.cc> <CALbthtdzW-_4TVngjt-VjCS6GqCEP967-UE7oEoDkBAVaRFOzw@mail.gmail.com>
 <20220822204112.GA19050@breakpoint.cc>
In-Reply-To: <20220822204112.GA19050@breakpoint.cc>
From:   Gabriel Ryan <gabe@cs.columbia.edu>
Date:   Mon, 22 Aug 2022 16:51:55 -0400
Message-ID: <CALbthteTSmd9xmBUdBSRzFNMqFemxnba=SnvNgY5KrLYEvpMhQ@mail.gmail.com>
Subject: Re: data-race in nf_tables_newtable / nf_tables_newtable
To:     Florian Westphal <fw@strlen.de>
Cc:     Abhishek Shah <abhishek.shah@columbia.edu>, coreteam@netfilter.org,
        davem@davemloft.net, edumazet@google.com, kadlec@netfilter.org,
        kuba@kernel.org, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org, pabeni@redhat.com,
        pablo@netfilter.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: mrUGhl6esgkS61UHd770hu-m0ISEc-rw
X-Proofpoint-ORIG-GUID: mrUGhl6esgkS61UHd770hu-m0ISEc-rw
X-CU-OB: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_13,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 suspectscore=0 spamscore=0 phishscore=0 mlxscore=0 bulkscore=10
 malwarescore=0 lowpriorityscore=10 mlxlogscore=862 impostorscore=10
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208220084
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, glad everything worked out then, thanks for sharing!

Best,

Gabe

On Mon, Aug 22, 2022 at 4:42 PM Florian Westphal <fw@strlen.de> wrote:
>
> Gabriel Ryan <gabe@cs.columbia.edu> wrote:
> > Hi Florian,
> >
> > I just looked at the lock event trace from our report and it looks
> > like two distinct commit mutexes were held when the race was
> > triggered. I think the race is probably on the table_handle variable
> > on net/netfilter/nf_tables_api.c:1221, and not the table->handle field
> > being written to.
>
> See
>
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__patchwork.ozlabs.o=
rg_project_netfilter-2Ddevel_patch_20220821085939.571378-2D1-2Dpablo-40netf=
ilter.org_&d=3DDwIFAg&c=3D009klHSCxuh5AI1vNQzSO0KGjl4nbi2Q0M1QLJX9BeE&r=3DE=
yAJYRJu01oaAhhVVY3o8zKgZvacDAXd_PNRtaqACCo&m=3DtKybb4B0md9Rrb5d9AH-UN2fjr4L=
8y6LtRxywepWhKsWCyN0OWaRwAtDbGt10WQD&s=3DuJ4BtOvCcZOe6F17rDKQipDF0McLeOwaUL=
9jO3BgTCU&e=3D
>
> which makes table_handle per netns.
