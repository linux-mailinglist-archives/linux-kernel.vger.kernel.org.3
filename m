Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 348835332A1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 22:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241733AbiEXUvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 16:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241740AbiEXUus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 16:50:48 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D911784A0F
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 13:50:46 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 1965D3200258;
        Tue, 24 May 2022 16:50:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 24 May 2022 16:50:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        tom-fitzhenry.me.uk; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1653425442; x=
        1653511842; bh=Lf4XHG/C5S0ce8kD2Vfy/CrWk8hvpWu/Yqggv+zx83U=; b=g
        sM0Xsy/r6R36H9JumA2trxpyQF3MQT+CDL5Hygoqk5COWMaIboKRn+CtfZq+QLpj
        urP495w0eSbYQgq2EKUQ2rkD3XRQ748ZgXM67XQN3K/w/i0paAppK12wXUhjolMm
        5qIiNJ2kom+LTlsLy865piqhcgu5WhKeBQGFmIkuulWdDkfYMVHLev/dxnLVmy0k
        8685TETAnIEIAQ7fneVr0N8ujsdSVgwR6aznrRi9kFkjpSJoelrgwurl7DztkMwC
        JGtLs9x2f3YITzm53MnSPg93g90dslE8pgrOnn5EOne/2w/1Zt5WAeS9M1k9ARBn
        RFSVeC6GTyCEAOaqAJf6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1653425442; x=1653511842; bh=Lf4XHG/C5S0ce8kD2Vfy/CrWk8hv
        pWu/Yqggv+zx83U=; b=Aco8xmx54ucjrDHQt9QeMrLcfo0fSR9xmHzrdFTpagD5
        kHWlPESnumZexYR74DS++hnJ6gvVtlu0+OGjRTOcGlQlv4hPE87jTl6pbXJlhX1P
        So1ZorS9MnqZR+6f3Oh3D9dR2yYpPkAFatxSLVCvEiBK48NQWMsUyPAtjPNKUaLA
        sVLdm3QU+o+opvArXFICfeq+91fM6JnRLV2xhK5jwquMi4t8Y2axP2nUC4jjyGET
        KEM4984o84rut8460F3E0wde4zKLp3BkweJInhRt3jbi/JhUXxb2uUdHkDUpCsdk
        l/oJaRCEyCmNKKonCn6BANZamy2TKPpMGFcvdrp4Hg==
X-ME-Sender: <xms:IkWNYsZHcs9KAMki7w4RkUn5vWLcafxMpXg4C7J440vXWqwlB_AeNg>
    <xme:IkWNYnaPoia37UXyVP2cUCWn2pzD4YyROsUDmE6xYezNZHKdgeou0DvInc3pgqX8O
    986X5CsbqE4vvX7Vw>
X-ME-Received: <xmr:IkWNYm9xQwybidJS5TTYibK4OAehs8gSe8PfxbUJrjDqT4iN5yIJ9DSWdUCsDeI2mtqw2ozOVJCA1oFYbsClQkMe>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrjeefgdduheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurheptgfkffggfgfvvehfhffujgesmhdtreertdefjeenucfhrhhomhepvfhomhcu
    hfhithiihhgvnhhrhicuoehtohhmsehtohhmqdhfihhtiihhvghnrhihrdhmvgdruhhkqe
    enucggtffrrghtthgvrhhnpeevvdejueeukefhffeuledukeffjeefleehjeeltdehveeg
    veejveekkeffleeludenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhpihhnvgeige
    drohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehtohhmsehtohhmqdhfihhtiihhvghnrhihrdhmvgdruhhk
X-ME-Proxy: <xmx:IkWNYmpy2OlclSQj7csPqdnYavjAxgxeRpX594-8SP8fwKbcJdtZTQ>
    <xmx:IkWNYnq376kq_lowSuYgiWbGtaF0MBi1XuI0Qz1ufGjWvbjzgJOZFw>
    <xmx:IkWNYkRXRysxIJ_rBYnUooGOgS_QxC5TcmtULGBU0Qv4w62P014MIA>
    <xmx:IkWNYgTDMdVS30quMtoXw-swb2sEmGLlUhblvXjndy1ZUI5kqVl5zw>
Feedback-ID: iefc945ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 May 2022 16:50:38 -0400 (EDT)
Content-Type: multipart/mixed; boundary="------------xmfdz0PbQ1HyqNlhZAnnVVXg"
Message-ID: <28d3925a-983a-fcb8-19af-6e6baf892d53@tom-fitzhenry.me.uk>
Date:   Wed, 25 May 2022 06:50:36 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Martijn Braam <martijn@brixit.nl>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220523055541.724422-1-tom@tom-fitzhenry.me.uk>
 <65339d49135ffb578b5cd5ae459cea8a@walle.cc>
From:   Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
Subject: Re: [PATCH] mtd: spi-nor: gigadevice: add support for gd25lq128e
In-Reply-To: <65339d49135ffb578b5cd5ae459cea8a@walle.cc>
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------xmfdz0PbQ1HyqNlhZAnnVVXg
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/5/22 18:03, Michael Walle wrote:
> According to JEP106BC the vendor code 0x25 is Tristar. I'm
> not sure what is going on here.

Nor I! The board schematic[0] reports the use of GD25LQ128EWIGR (vendor 
Gigadevices), but indeed the chip itself reports vendor Tristar.

I will ask the community/vendor about this discrepancy.

> This flash supports SFDP, please provide an SFDP dump, see [1].

I will include this in my v2 patch. For posterity, here's the dump:

$ xxd -p /sys/bus/spi/devices/spi0.0/spi-nor/sfdp
53464450060101ff00060110300000ff9d05010380000002ffffffffffff
ffffffffffffffffffffffffffffffffffffe520f9ffffffff0744eb086b
083b80bbfeffffffffff00ffffff44eb0c200f5210d800ff234ac90082d8
11c7cccd68467a757a75f7a2d55c4a422cfff030c080ffffffffffffffff
ffffffffffffffff501950169cf9c0648fecffff
$ md5sum /sys/bus/spi/devices/spi0.0/spi-nor/sfdp
de4d6be54e479d60859b0ca8a0ee9216  /sys/bus/spi/devices/spi0.0/spi-nor/sfdp
$ cat /sys/bus/spi/devices/spi0.0/spi-nor/jedec_id
257018
$ cat /sys/bus/spi/devices/spi0.0/spi-nor/partname
gd25lq128e
$ cat /sys/bus/spi/devices/spi0.0/spi-nor/manufacturer
gigadevice

I have attached the parsed sfdp, according to 
https://github.com/petris/sfdp-parser

> Did you test locking?

No. The datasheet mentions Status Register locking, but I will look into 
how to adequately test this.

> As this flash supports SFDP, please use SNOR_ID3(0x257018)
> and drop both the INFO() and the NO_SFDP_FLAGS(). You'll
> need my SNOR_ID3() patches [2].

SGTM, will do.

Thanks for your feedback!


0. 
https://files.pine64.org/doc/PinePhonePro/PinephonePro-Schematic-V1.0-20211127.pdf 
  page 11, "GD25LQ128EWIGR"
--------------xmfdz0PbQ1HyqNlhZAnnVVXg
Content-Type: text/plain; charset=UTF-8; name="sfdp_parsed.txt"
Content-Disposition: attachment; filename="sfdp_parsed.txt"
Content-Transfer-Encoding: base64

U2lnbmF0dXJlOiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMHg1MDQ0
NDY1MyAoTXVzdCBiZSAweDUwNDQ0NjUzICgnUycsICdGJywgJ0QnLCAnUCcpKQpNYWpvcjog
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAxCk1p
bm9yOiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IDYKUGFyYW1ldGVyczogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgMgpUb3RhbCBsZW5ndGg6ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgMTQwCgoKUGFyYW1ldGVyIDAgKEJhc2ljIGZsYXNoIHBhcmFtZXRlciB0YWJs
ZSkKTWFqb3I6ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IDB4ZmYwMApNYWpvcjogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAxCk1pbm9yOiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIDYKT2Zmc2V0OiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICA0OApMZW5ndGg6ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIDY0CkVyYXNlIFNpemU6ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDEgKDRrQiBzdXBwb3J0ZWQpCldyaXRl
IEdyYW51bGFyaXR5OiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDEg
KDY0IGJ5dGVzIG9yIG1vcmUpClZvbGF0aWxlIFN0YXR1cyBSZWdpc3RlciBCbG9jayBQcm90
ZWN0IEJpdHM6ICAgICAgICAgICAgIDAgKG5vbi12b2xhdGlsZSkKV3JpdGUgRW5hYmxlIElu
c3RydWN0aW9uIGZvciBXcml0aW5nIHRvIFZvbGF0aWxlIFN0YXR1cyBSZWdpc3RlcjogMCAo
NTBoKQo0a0IgRXJhc2UgSW5zdHJ1Y3Rpb246ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAweDIwCjEtMS0yIEZhc3QgUmVhZDogICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIDEgKHN1cHBvcnRlZCkKQWRkcmVzcyBCeXRlczogICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMCAoMy1ieXRlIGFkZHJlc3NpbmcpCkRv
dWJsZSB0cmFuc2ZlciByYXRlIChEVFIpIENsb2NraW5nOiAgICAgICAgICAgICAgICAgICAg
IDEgKHN1cHBvcnRlZCkKMS0yLTIgRmFzdCBSZWFkOiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgMSAoc3VwcG9ydGVkKQoxLTQtNCBGYXN0IFJlYWQ6ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAxIChzdXBwb3J0ZWQpCjEtMS00
IEZhc3QgUmVhZDogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDEg
KHN1cHBvcnRlZCkKRmxhc2ggTWVtb3J5IERlbnNpdHk6ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAxNjc3NzIxNSAoaW4gYnl0ZXMpCjEtNC00IEZhc3QgUmVhZCBOdW1iZXIgb2Yg
V2FpdCBTdGF0ZXMgTmVlZGVkOiAgICAgICAgICAgIDQKMS00LTQgRmFzdCBSZWFkIE51bWJl
ciBvZiBNb2RlIENsb2NrczogICAgICAgICAgICAgICAgICAgMgoxLTQtNCBGYXN0IFJlYWQg
SW5zdHJ1Y3Rpb25zOiAgICAgICAgICAgICAgICAgICAgICAgICAweGViCjEtMS00IEZhc3Qg
UmVhZCBOdW1iZXIgb2YgV2FpdCBTdGF0ZXMgTmVlZGVkOiAgICAgICAgICAgIDgKMS0xLTQg
RmFzdCBSZWFkIE51bWJlciBvZiBNb2RlIENsb2NrczogICAgICAgICAgICAgICAgICAgMAox
LTEtNCBGYXN0IFJlYWQgSW5zdHJ1Y3Rpb25zOiAgICAgICAgICAgICAgICAgICAgICAgICAw
eDZiCjEtMS0yIEZhc3QgUmVhZCBOdW1iZXIgb2YgV2FpdCBTdGF0ZXMgTmVlZGVkOiAgICAg
ICAgICAgIDgKMS0xLTIgRmFzdCBSZWFkIE51bWJlciBvZiBNb2RlIENsb2NrczogICAgICAg
ICAgICAgICAgICAgMAoxLTEtMiBGYXN0IFJlYWQgSW5zdHJ1Y3Rpb25zOiAgICAgICAgICAg
ICAgICAgICAgICAgICAweDNiCjEtMi0yIEZhc3QgUmVhZCBOdW1iZXIgb2YgV2FpdCBTdGF0
ZXMgTmVlZGVkOiAgICAgICAgICAgIDAKMS0yLTIgRmFzdCBSZWFkIE51bWJlciBvZiBNb2Rl
IENsb2NrczogICAgICAgICAgICAgICAgICAgNAoxLTItMiBGYXN0IFJlYWQgSW5zdHJ1Y3Rp
b25zOiAgICAgICAgICAgICAgICAgICAgICAgICAweGJiCjItMi0yIEZhc3QgUmVhZDogICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDAgKG5vdCBzdXBwb3J0ZWQp
CjQtNC00IEZhc3QgUmVhZDogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIDEgKHN1cHBvcnRlZCkKMi0yLTIgRmFzdCBSZWFkIE51bWJlciBvZiBXYWl0IFN0YXRl
cyBOZWVkZWQ6ICAgICAgICAgICAgMAoyLTItMiBGYXN0IFJlYWQgTnVtYmVyIG9mIE1vZGUg
Q2xvY2tzOiAgICAgICAgICAgICAgICAgICAwCjItMi0yIEZhc3QgUmVhZCBJbnN0cnVjdGlv
bnM6ICAgICAgICAgICAgICAgICAgICAgICAgIDB4ZmYKNC00LTQgRmFzdCBSZWFkIE51bWJl
ciBvZiBXYWl0IFN0YXRlcyBOZWVkZWQ6ICAgICAgICAgICAgNAo0LTQtNCBGYXN0IFJlYWQg
TnVtYmVyIG9mIE1vZGUgQ2xvY2tzOiAgICAgICAgICAgICAgICAgICAyCjQtNC00IEZhc3Qg
UmVhZCBJbnN0cnVjdGlvbnM6ICAgICAgICAgICAgICAgICAgICAgICAgIDB4ZWIKRXJhc2Ug
VHlwZSAxIFNpemU6ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgNDA5NiAo
aW4gYnl0ZXMpCkVyYXNlIFR5cGUgMSBJbnN0cnVjdGlvbjogICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIDB4MjAKRXJhc2UgVHlwZSAyIFNpemU6ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAzMjc2OCAoaW4gYnl0ZXMpCkVyYXNlIFR5cGUgMiBJbnN0cnVjdGlv
bjogICAgICAgICAgICAgICAgICAgICAgICAgICAgIDB4NTIKRXJhc2UgVHlwZSAzIFNpemU6
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA2NTUzNiAoaW4gYnl0ZXMpCkVy
YXNlIFR5cGUgMyBJbnN0cnVjdGlvbjogICAgICAgICAgICAgICAgICAgICAgICAgICAgIDB4
ZDgKRXJhc2UgVHlwZSA0IFNpemU6ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgMSAobm90IHN1cHBvcnRlZCkKRXJhc2UgVHlwZSA0IEluc3RydWN0aW9uOiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgMHhmZgpUeXBpY2FsIEVyYXNlIFRpbWUgdG8gTWF4
aW11bSBFcmFzZSBUaW1lIE11bHRpcGxpZXI6ICAgICA4CkVyYXNlIFR5cGUgMSBUeXBpY2Fs
IFRpbWU6ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAyNTYgKGluIG1pbGxpc2Vjb25k
cykKRXJhc2UgVHlwZSAyIFR5cGljYWwgVGltZTogICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIDE2MCAoaW4gbWlsbGlzZWNvbmRzKQpFcmFzZSBUeXBlIDQgVHlwaWNhbCBUaW1lOiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgMzA0IChpbiBtaWxsaXNlY29uZHMpCkVyYXNl
IFR5cGUgNCBUeXBpY2FsIFRpbWU6ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDEg
KGluIG1pbGxpc2Vjb25kcykKVHlwaWNhbCBQcm9ncmFtIFRpbWUgdG8gTWF4aW11bSBQcm9n
cmFtIFRpbWUgTXVsdGlwbGllcjogNgpQYWdlIFNpemU6ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgMjU2ClR5cGljYWwgUGFnZSBQcm9ncmFtIFRpbWU6
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAyMDAgKGluIG1pY3Jvc2Vjb25kcykKVHlw
aWNhbCBGaXJzdCBCeXRlIFByb2dyYW0gVGltZTogICAgICAgICAgICAgICAgICAgICAgICAg
OCAoaW4gbWljcm9zZWNvbmRzKQpUeXBpY2FsIEFkZGl0aW9uYWwgQnl0ZSBQcm9ncmFtIFRp
bWU6ICAgICAgICAgICAgICAgICAgICAzIChpbiBtaWNyb3NlY29uZHMpClR5cGljYWwgQ2hp
cCBFcmFzZSBUaW1lOiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMzIwMDAgKGluIG1p
bGxpc2Vjb25kcykKCgpQYXJhbWV0ZXIgMSAoVW5rbm93biBwYXJhbWV0ZXIpCk1ham9yOiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMHgyOWQKTWFq
b3I6ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
MQpNaW5vcjogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICA1Ck9mZnNldDogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAxMjgKTGVuZ3RoOiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAxMgpXb3JkIDA6ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAweDE2NTAxOTUwCldvcmQgMTogICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIDB4NjRjMGY5OWMKV29yZCAyOiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgMHhmZmZmZWM4Zgo=

--------------xmfdz0PbQ1HyqNlhZAnnVVXg--
